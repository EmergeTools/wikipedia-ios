
import Foundation

final class ArticleCacheDBWriter: NSObject, CacheDBWriting {
    
    weak var delegate: CacheDBWritingDelegate?
    private let articleFetcher: ArticleFetcher
    private let cacheBackgroundContext: NSManagedObjectContext
    private let imageController: ImageCacheController
    
    var groupedTasks: [String : [IdentifiedTask]] = [:]

    init(articleFetcher: ArticleFetcher, cacheBackgroundContext: NSManagedObjectContext, delegate: CacheDBWritingDelegate? = nil, imageController: ImageCacheController) {
        
        self.articleFetcher = articleFetcher
        self.cacheBackgroundContext = cacheBackgroundContext
        self.delegate = delegate
        self.imageController = imageController
   }
    
    func add(url: URL, groupKey: String, itemKey: String) {
        cacheEndpoint(articleURL: url, endpointType: .mobileHTML, groupKey: groupKey)
        cacheEndpoint(articleURL: url, endpointType: .mobileHtmlOfflineResources, groupKey: groupKey)
        cacheEndpoint(articleURL: url, endpointType: .mediaList, groupKey: groupKey)
        
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 10) {
            self.fetchAndPrintEachItem()
            self.fetchAndPrintEachGroup()
        }
    }
}

//Migration

extension ArticleCacheDBWriter {
    func cacheMobileHtmlFromMigration(desktopArticleURL: URL, itemKey: String? = nil, successCompletion: @escaping (PersistentCacheItem) -> Void) { //articleURL should be desktopURL
        guard let groupKey = desktopArticleURL.wmf_databaseKey else {
            return
        }
        
        let finalItemKey = itemKey ?? groupKey
        
        cacheURL(groupKey: groupKey, itemKey: finalItemKey) { (item) in
            self.cacheBackgroundContext.perform {
                item.fromMigration = true
                CacheDBWriterHelper.save(moc: self.cacheBackgroundContext) { (result) in
                    switch result {
                    case .success:
                        successCompletion(item)
                    case .failure:
                        break
                        //tonitodo: error handling
                    }
                }
            }
        }
    }
    
    func migratedCacheItemFile(cacheItem: PersistentCacheItem, successCompletion: @escaping () -> Void) {
        cacheBackgroundContext.perform {
            cacheItem.fromMigration = false
            cacheItem.isDownloaded = true
            CacheDBWriterHelper.save(moc: self.cacheBackgroundContext) { (result) in
                switch result {
                case .success:
                    successCompletion()
                default:
                    break
                }
            }
        }
        
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 10) {
            self.fetchAndPrintEachItem()
            self.fetchAndPrintEachGroup()
        }
    }
}

private extension ArticleCacheDBWriter {
    
    func cacheEndpoint(articleURL: URL, endpointType: ArticleFetcher.EndpointType, groupKey: String) {
        
        switch endpointType {
        case .mobileHTML:
            cacheURL(groupKey: groupKey, itemKey: groupKey)
        case .mobileHtmlOfflineResources, .mediaList:
            
            guard let siteURL = articleURL.wmf_site,
                let articleTitle = articleURL.wmf_title else {
                return
            }
            
            let untrackKey = UUID().uuidString
            let task = articleFetcher.fetchResourceList(siteURL: siteURL, articleTitle: articleTitle, endpointType: endpointType) { (result) in
                switch result {
                case .success(let urls):
                    for url in urls {
                        
                        guard let itemKey = url.wmf_databaseKey else {
                            continue
                        }
                        
                        if endpointType == .mediaList {
                            self.imageController.add(url: url, groupKey: groupKey, itemKey: itemKey)
                            continue
                        }
                        
                        self.cacheURL(groupKey: groupKey, itemKey: itemKey)
                        
                    }
                case .failure:
                    break
                }
                
                self.untrackTask(untrackKey: untrackKey, from: groupKey)
            }
            
            if let task = task {
                trackTask(untrackKey: untrackKey, task: task, to: groupKey)
            }
        default:
            break
            
        }
    }
    
    func mobileHTMLTitle(from mobileHTMLURL: URL) -> String {
        return (mobileHTMLURL.lastPathComponent as NSString).wmf_normalizedPageTitle()
    }
    
    func cacheURL(groupKey: String, itemKey: String, successCompletion: ((PersistentCacheItem) -> Void)? = nil) {
        
        if delegate?.shouldQueue(groupKey: groupKey, itemKey: itemKey) ?? false {
            delegate?.queue(groupKey: groupKey, itemKey: itemKey)
            return
        }
        
        let context = self.cacheBackgroundContext
        context.perform {

            guard let group = CacheDBWriterHelper.fetchOrCreateCacheGroup(with: groupKey, in: context) else {
                self.delegate?.dbWriterDidFailAdd(groupKey: groupKey, itemKey: itemKey)
                return
            }
            
            guard let item = CacheDBWriterHelper.fetchOrCreateCacheItem(with: itemKey, in: context) else {
                self.delegate?.dbWriterDidFailAdd(groupKey: groupKey, itemKey: itemKey)
                return
            }
            
            group.addToCacheItems(item)
            
            CacheDBWriterHelper.save(moc: context) { (result) in
                switch result {
                case .success:
                    self.delegate?.dbWriterDidAdd(groupKey: groupKey, itemKey: itemKey)
                    successCompletion?(item)
                case .failure:
                    self.delegate?.dbWriterDidFailAdd(groupKey: groupKey, itemKey: itemKey)
                }
            }
        }
    }
}