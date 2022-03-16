
import XCTest
@testable import Wikipedia

class NotificationsCenterCellViewModelMentionTests: NotificationsCenterViewModelTests {

    override var dataFileName: String {
        get {
            return "notifications-wikipedia-mentions"
        }
    }
    
    func testMentionInUserTalk() throws {
        let notification = try fetchManagedObject(identifier: "1")
        guard let cellViewModel = NotificationsCenterCellViewModel(notification: notification, languageLinkController: languageLinkController, isEditing: false, configuration: configuration) else {
            throw TestError.failureConvertingManagedObjectToViewModel
        }
        
        try testMentionInUserTalkText(cellViewModel: cellViewModel)
        try testMentionInUserTalkIcons(cellViewModel: cellViewModel)
        try testMentionInUserTalkActions(cellViewModel: cellViewModel)
    }
    
    func testMentionInUserTalkEditSummary() throws {
        let notification = try fetchManagedObject(identifier: "2")
        guard let cellViewModel = NotificationsCenterCellViewModel(notification: notification, languageLinkController: languageLinkController, isEditing: false, configuration: configuration) else {
            throw TestError.failureConvertingManagedObjectToViewModel
        }
        
        try testMentionInUserTalkEditSummaryText(cellViewModel: cellViewModel)
        try testMentionInUserTalkEditSummaryIcons(cellViewModel: cellViewModel)
        try testMentionInUserTalkEditSummaryActions(cellViewModel: cellViewModel)
    }
    
    func testMentionInArticleTalk() throws {
        let notification = try fetchManagedObject(identifier: "3")
        guard let cellViewModel = NotificationsCenterCellViewModel(notification: notification, languageLinkController: languageLinkController, isEditing: false, configuration: configuration) else {
            throw TestError.failureConvertingManagedObjectToViewModel
        }
        
        try testMentionInArticleTalkText(cellViewModel: cellViewModel)
        try testMentionInArticleTalkIcons(cellViewModel: cellViewModel)
        try testMentionInArticleTalkActions(cellViewModel: cellViewModel)
    }
    
    func testMentionInArticleTalkEditSummary() throws {
        let notification = try fetchManagedObject(identifier: "4")
        guard let cellViewModel = NotificationsCenterCellViewModel(notification: notification, languageLinkController: languageLinkController, isEditing: false, configuration: configuration) else {
            throw TestError.failureConvertingManagedObjectToViewModel
        }
        
        try testMentionInArticleTalkEditSummaryText(cellViewModel: cellViewModel)
        try testMentionInArticleTalkEditSummaryIcons(cellViewModel: cellViewModel)
        try testMentionInArticleTalkEditSummaryActions(cellViewModel: cellViewModel)
    }
    
    func testMentionFailureAnonymous() throws {
        let notification = try fetchManagedObject(identifier: "5")
        guard let cellViewModel = NotificationsCenterCellViewModel(notification: notification, languageLinkController: languageLinkController, isEditing: false, configuration: configuration) else {
            throw TestError.failureConvertingManagedObjectToViewModel
        }
        
        try testMentionFailureAnonymousText(cellViewModel: cellViewModel)
        try testMentionFailureAnonymousIcons(cellViewModel: cellViewModel)
        try testMentionFailureAnonymousActions(cellViewModel: cellViewModel)
    }
    
    func testMentionFailureNotFound() throws {
        
        let notification = try fetchManagedObject(identifier: "6")
        guard let cellViewModel = NotificationsCenterCellViewModel(notification: notification, languageLinkController: languageLinkController, isEditing: false, configuration: configuration) else {
            throw TestError.failureConvertingManagedObjectToViewModel
        }
        
        try testMentionFailureNotFoundText(cellViewModel: cellViewModel)
        try testMentionFailureNotFoundIcons(cellViewModel: cellViewModel)
        try testMentionFailureNotFoundActions(cellViewModel: cellViewModel)
    }
    
    func testMentionSuccess() throws {
        let notification = try fetchManagedObject(identifier: "7")
        guard let cellViewModel = NotificationsCenterCellViewModel(notification: notification, languageLinkController: languageLinkController, isEditing: false, configuration: configuration) else {
            throw TestError.failureConvertingManagedObjectToViewModel
        }
        
        try testMentionSuccessText(cellViewModel: cellViewModel)
        try testMentionSuccessIcons(cellViewModel: cellViewModel)
        try testMentionSuccessActions(cellViewModel: cellViewModel)
    }
    
    func testMentionSuccessWikidata() throws {
        let notification = try fetchManagedObject(identifier: "8")
        guard let cellViewModel = NotificationsCenterCellViewModel(notification: notification, languageLinkController: languageLinkController, isEditing: false, configuration: configuration) else {
            throw TestError.failureConvertingManagedObjectToViewModel
        }
        
        try testMentionSuccessWikidataText(cellViewModel: cellViewModel)
        try testMentionSuccessWikidataIcons(cellViewModel: cellViewModel)
        try testMentionSuccessWikidataActions(cellViewModel: cellViewModel)
    }
    
    func testMentionInArticleTalkZhWikiquote() throws {
        let notification = try fetchManagedObject(identifier: "9")
        guard let cellViewModel = NotificationsCenterCellViewModel(notification: notification, languageLinkController: languageLinkController, isEditing: false, configuration: configuration) else {
            throw TestError.failureConvertingManagedObjectToViewModel
        }
        
        try testMentionInArticleTalkZhWikiquoteText(cellViewModel: cellViewModel)
        try testMentionInArticleTalkZhWikiquoteIcons(cellViewModel: cellViewModel)
        try testMentionInArticleTalkZhWikiquoteActions(cellViewModel: cellViewModel)
    }
    
    private func testActions(expectedText: String, expectedURL: URL?, expectedIconType: NotificationsCenterIconType?, actionToTest: NotificationsCenterAction, isMarkAsRead: Bool = false, isNotificationSettings: Bool = false) throws {
        let expectedActionData = NotificationsCenterActionData(text: expectedText, url: expectedURL, iconType: expectedIconType)
        let expectedAction: NotificationsCenterAction
        if isMarkAsRead {
            expectedAction = NotificationsCenterAction.markAsReadOrUnread(expectedActionData)
        } else if isNotificationSettings {
            expectedAction = NotificationsCenterAction.notificationSubscriptionSettings(expectedActionData)
        } else {
            expectedAction = NotificationsCenterAction.custom(expectedActionData)
        }
        XCTAssertEqual(actionToTest, expectedAction, "Invalid action")
    }
    
    private func testMentionInUserTalkText(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertEqual(cellViewModel.headerText, "Section Title", "Invalid headerText")
        XCTAssertEqual(cellViewModel.subheaderText, "From Fred The Bird", "Invalid subheaderText")
        XCTAssertEqual(cellViewModel.bodyText, "Reply text mention in talk page User:Jack The Cat", "Invalid bodyText")
        XCTAssertEqual(cellViewModel.footerText, "User talk:Fred The Bird", "Invalid footerText")
        XCTAssertEqual(cellViewModel.dateText, "7/16/21", "Invalid dateText")
        XCTAssertEqual(cellViewModel.projectText, "EN", "Invalid projectText")
    }
    
    private func testMentionInUserTalkIcons(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertNil(cellViewModel.projectIconName, "Invalid projectIconName")
        XCTAssertEqual(cellViewModel.footerIconType, .personFill, "Invalid footerIconType")
    }
    
    private func testMentionInUserTalkActions(cellViewModel: NotificationsCenterCellViewModel) throws {

        XCTAssertEqual(cellViewModel.sheetActions.count, 6, "Invalid sheetActionsCount")
        
        let expectedText0 = "Mark as unread"
        let expectedURL0: URL? = nil
        let expectedIconType0: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText0, expectedURL: expectedURL0, expectedIconType: expectedIconType0, actionToTest: cellViewModel.sheetActions[0], isMarkAsRead: true)
        
        let expectedText1 = "Go to Fred The Bird\'s user page"
        let expectedURL1: URL? = URL(string: "https://en.wikipedia.org/wiki/User:Fred_The_Bird")!
        let expectedIconType1: NotificationsCenterIconType? = .person
        try testActions(expectedText: expectedText1, expectedURL: expectedURL1, expectedIconType: expectedIconType1, actionToTest: cellViewModel.sheetActions[1])
        
        let expectedText2 = "Go to diff"
        let expectedURL2: URL? = URL(string: "https://en.wikipedia.org/w/index.php?oldid=1033968824&title=User_talk%253AFred_The_Bird")!
        let expectedIconType2: NotificationsCenterIconType? = .diff
        try testActions(expectedText: expectedText2, expectedURL: expectedURL2, expectedIconType: expectedIconType2, actionToTest: cellViewModel.sheetActions[2])
        
        let expectedText3 = "Go to User talk:Fred The Bird"
        let expectedURL3: URL? = URL(string: "https://en.wikipedia.org/wiki/User_talk:Fred_The_Bird#Section_Title")!
        let expectedIconType3: NotificationsCenterIconType? = .document
        try testActions(expectedText: expectedText3, expectedURL: expectedURL3, expectedIconType: expectedIconType3, actionToTest: cellViewModel.sheetActions[3])
        
        let expectedText4 = "Go to User talk:Fred The Bird"
        let expectedURL4: URL? = URL(string: "https://en.wikipedia.org/wiki/User_talk:Fred_The_Bird#Section_Title")!
        let expectedIconType4: NotificationsCenterIconType? = .document
        try testActions(expectedText: expectedText4, expectedURL: expectedURL4, expectedIconType: expectedIconType4, actionToTest: cellViewModel.sheetActions[4])
        
        let expectedText5 = "Notification settings"
        let expectedURL5: URL? = nil
        let expectedIconType5: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText5, expectedURL: expectedURL5, expectedIconType: expectedIconType5, actionToTest: cellViewModel.sheetActions[5], isNotificationSettings: true)
    }
    
    private func testMentionInUserTalkEditSummaryText(cellViewModel: NotificationsCenterCellViewModel) throws {

        XCTAssertEqual(cellViewModel.headerText, "Mention in edit summary", "Invalid headerText")
        XCTAssertEqual(cellViewModel.subheaderText, "From Fred The Bird", "Invalid subheaderText")
        XCTAssertEqual(cellViewModel.bodyText, "Edit Summary Text: User:Jack The Cat", "Invalid bodyText")
        XCTAssertEqual(cellViewModel.footerText, "User talk:Fred The Bird", "Invalid footerText")
        XCTAssertEqual(cellViewModel.dateText, "7/16/21", "Invalid dateText")
        XCTAssertEqual(cellViewModel.projectText, "EN", "Invalid projectText")
    }
    
    private func testMentionInUserTalkEditSummaryIcons(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertNil(cellViewModel.projectIconName, "Invalid projectIconName")
        XCTAssertEqual(cellViewModel.footerIconType, .personFill, "Invalid footerIconType")
    }
    
    private func testMentionInUserTalkEditSummaryActions(cellViewModel: NotificationsCenterCellViewModel) throws {
        
        XCTAssertEqual(cellViewModel.sheetActions.count, 5, "Invalid sheetActionsCount")
        
        let expectedText0 = "Mark as unread"
        let expectedURL0: URL? = nil
        let expectedIconType0: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText0, expectedURL: expectedURL0, expectedIconType: expectedIconType0, actionToTest: cellViewModel.sheetActions[0], isMarkAsRead: true)
        
        let expectedText1 = "Go to Fred The Bird\'s user page"
        let expectedURL1: URL? = URL(string: "https://en.wikipedia.org/wiki/User:Fred_The_Bird")!
        let expectedIconType1: NotificationsCenterIconType? = .person
        try testActions(expectedText: expectedText1, expectedURL: expectedURL1, expectedIconType: expectedIconType1, actionToTest: cellViewModel.sheetActions[1])
        
        let expectedText2 = "Go to diff"
        let expectedURL2: URL? = URL(string: "https://en.wikipedia.org/w/index.php?oldid=1033968849&title=User_talk%253AFred_The_Bird")!
        let expectedIconType2: NotificationsCenterIconType? = .diff
        try testActions(expectedText: expectedText2, expectedURL: expectedURL2, expectedIconType: expectedIconType2, actionToTest: cellViewModel.sheetActions[2])
        
        let expectedText3 = "Go to User talk:Fred The Bird"
        let expectedURL3: URL? = URL(string: "https://en.wikipedia.org/wiki/User_talk:Fred_The_Bird")!
        let expectedIconType3: NotificationsCenterIconType? = .document
        try testActions(expectedText: expectedText3, expectedURL: expectedURL3, expectedIconType: expectedIconType3, actionToTest: cellViewModel.sheetActions[3])
        
        let expectedText4 = "Notification settings"
        let expectedURL4: URL? = nil
        let expectedIconType4: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText4, expectedURL: expectedURL4, expectedIconType: expectedIconType4, actionToTest: cellViewModel.sheetActions[4], isNotificationSettings: true)
    }
    
    private func testMentionInArticleTalkText(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertEqual(cellViewModel.headerText, "Section Title", "Invalid headerText")
        XCTAssertEqual(cellViewModel.subheaderText, "From Fred The Bird", "Invalid subheaderText")
        XCTAssertEqual(cellViewModel.bodyText, "Jack The Cat Reply text mention in talk page.")
        XCTAssertEqual(cellViewModel.footerText, "Talk:Blue Bird", "Invalid footerText")
        XCTAssertEqual(cellViewModel.dateText, "3/14/22", "Invalid dateText")
        XCTAssertEqual(cellViewModel.projectText, "TEST", "Invalid projectText")
    }
    
    private func testMentionInArticleTalkIcons(cellViewModel: NotificationsCenterCellViewModel) throws {
        
        let notification = try fetchManagedObject(identifier: "3")
        guard let cellViewModel = NotificationsCenterCellViewModel(notification: notification, languageLinkController: languageLinkController, isEditing: false, configuration: configuration) else {
            throw TestError.failureConvertingManagedObjectToViewModel
        }
        
        XCTAssertNil(cellViewModel.projectIconName, "Invalid projectIconName")
        XCTAssertEqual(cellViewModel.footerIconType, .personFill, "Invalid footerIconType")
    }
    
    private func testMentionInArticleTalkActions(cellViewModel: NotificationsCenterCellViewModel) throws {

        XCTAssertEqual(cellViewModel.sheetActions.count, 6, "Invalid sheetActionsCount")
        
        let expectedText0 = "Mark as unread"
        let expectedURL0: URL? = nil
        let expectedIconType0: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText0, expectedURL: expectedURL0, expectedIconType: expectedIconType0, actionToTest: cellViewModel.sheetActions[0], isMarkAsRead: true)
        
        let expectedText1 = "Go to Fred The Bird\'s user page"
        let expectedURL1: URL? = URL(string: "https://test.wikipedia.org/wiki/User:Fred_The_Bird")!
        let expectedIconType1: NotificationsCenterIconType? = .person
        try testActions(expectedText: expectedText1, expectedURL: expectedURL1, expectedIconType: expectedIconType1, actionToTest: cellViewModel.sheetActions[1])
        
        let expectedText2 = "Go to diff"
        let expectedURL2: URL? = URL(string: "https://test.wikipedia.org/w/index.php?oldid=505586&title=Talk%253ABlue_Bird")!
        let expectedIconType2: NotificationsCenterIconType? = .diff
        try testActions(expectedText: expectedText2, expectedURL: expectedURL2, expectedIconType: expectedIconType2, actionToTest: cellViewModel.sheetActions[2])
        
        let expectedText3 = "Go to Talk:Blue Bird"
        let expectedURL3: URL? = URL(string: "https://test.wikipedia.org/wiki/Talk:Blue_Bird#Section_Title")!
        let expectedIconType3: NotificationsCenterIconType? = .document
        try testActions(expectedText: expectedText3, expectedURL: expectedURL3, expectedIconType: expectedIconType3, actionToTest: cellViewModel.sheetActions[3])
        
        let expectedText4 = "Go to Blue Bird"
        let expectedURL4: URL? = URL(string: "https://test.wikipedia.org/wiki/Blue_Bird#Section_Title")!
        let expectedIconType4: NotificationsCenterIconType? = .document
        try testActions(expectedText: expectedText4, expectedURL: expectedURL4, expectedIconType: expectedIconType4, actionToTest: cellViewModel.sheetActions[4])
        
        let expectedText5 = "Notification settings"
        let expectedURL5: URL? = nil
        let expectedIconType5: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText5, expectedURL: expectedURL5, expectedIconType: expectedIconType5, actionToTest: cellViewModel.sheetActions[5], isNotificationSettings: true)
    }
    
    private func testMentionInArticleTalkEditSummaryText(cellViewModel: NotificationsCenterCellViewModel) throws {
        
        XCTAssertEqual(cellViewModel.headerText, "Mention in edit summary", "Invalid headerText")
        XCTAssertEqual(cellViewModel.subheaderText, "From Fred The Bird", "Invalid subheaderText")
        XCTAssertEqual(cellViewModel.bodyText, "Edit Summary Text User:Jack The Cat")
        XCTAssertEqual(cellViewModel.footerText, "Black Cat", "Invalid footerText")
        XCTAssertEqual(cellViewModel.dateText, "1/6/22", "Invalid dateText")
        XCTAssertEqual(cellViewModel.projectText, "TEST", "Invalid projectText")
    }
    
    private func testMentionInArticleTalkEditSummaryIcons(cellViewModel: NotificationsCenterCellViewModel) throws {

        XCTAssertNil(cellViewModel.projectIconName, "Invalid projectIconName")
        XCTAssertEqual(cellViewModel.footerIconType, .documentFill, "Invalid footerIconType")
    }
    
    private func testMentionInArticleTalkEditSummaryActions(cellViewModel: NotificationsCenterCellViewModel) throws {

        XCTAssertEqual(cellViewModel.sheetActions.count, 5, "Invalid sheetActionsCount")
        
        let expectedText0 = "Mark as unread"
        let expectedURL0: URL? = nil
        let expectedIconType0: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText0, expectedURL: expectedURL0, expectedIconType: expectedIconType0, actionToTest: cellViewModel.sheetActions[0], isMarkAsRead: true)
        
        let expectedText1 = "Go to Fred The Bird\'s user page"
        let expectedURL1: URL? = URL(string: "https://test.wikipedia.org/wiki/User:Fred_The_Bird")!
        let expectedIconType1: NotificationsCenterIconType? = .person
        try testActions(expectedText: expectedText1, expectedURL: expectedURL1, expectedIconType: expectedIconType1, actionToTest: cellViewModel.sheetActions[1])
        
        let expectedText2 = "Go to diff"
        let expectedURL2: URL? = URL(string: "https://test.wikipedia.org/w/index.php?oldid=497048&title=Black_Cat")!
        let expectedIconType2: NotificationsCenterIconType? = .diff
        try testActions(expectedText: expectedText2, expectedURL: expectedURL2, expectedIconType: expectedIconType2, actionToTest: cellViewModel.sheetActions[2])
        
        let expectedText3 = "Go to Black Cat"
        let expectedURL3: URL? = URL(string: "https://test.wikipedia.org/wiki/Black_Cat")!
        let expectedIconType3: NotificationsCenterIconType? = .document
        try testActions(expectedText: expectedText3, expectedURL: expectedURL3, expectedIconType: expectedIconType3, actionToTest: cellViewModel.sheetActions[3])
        
        let expectedText4 = "Notification settings"
        let expectedURL4: URL? = nil
        let expectedIconType4: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText4, expectedURL: expectedURL4, expectedIconType: expectedIconType4, actionToTest: cellViewModel.sheetActions[4], isNotificationSettings: true)
    }
    
    private func testMentionFailureAnonymousText(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertEqual(cellViewModel.headerText, "Failed mention")
        XCTAssertEqual(cellViewModel.subheaderText, "Alert from EN-Wikipedia", "Invalid subheaderText")
        XCTAssertEqual(cellViewModel.bodyText, "Your mention of 47.188.91.144 was not sent because the user is anonymous.")
        XCTAssertEqual(cellViewModel.footerText, "User talk:Fred The Bird", "Invalid footerText")
        XCTAssertEqual(cellViewModel.dateText, "7/16/21", "Invalid dateText")
        XCTAssertEqual(cellViewModel.projectText, "EN", "Invalid projectText")
    }
    
    private func testMentionFailureAnonymousIcons(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertNil(cellViewModel.projectIconName, "Invalid projectIconName")
        XCTAssertEqual(cellViewModel.footerIconType, .personFill, "Invalid footerIconType")
    }
    
    private func testMentionFailureAnonymousActions(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertEqual(cellViewModel.sheetActions.count, 3, "Invalid sheetActionsCount")
        
        let expectedText0 = "Mark as unread"
        let expectedURL0: URL? = nil
        let expectedIconType0: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText0, expectedURL: expectedURL0, expectedIconType: expectedIconType0, actionToTest: cellViewModel.sheetActions[0], isMarkAsRead: true)
        
        let expectedText1 = "Go to User talk:Fred The Bird"
        let expectedURL1: URL? = URL(string: "https://en.wikipedia.org/wiki/User_talk:Fred_The_Bird#Section_Title")!
        let expectedIconType1: NotificationsCenterIconType? = .document
        try testActions(expectedText: expectedText1, expectedURL: expectedURL1, expectedIconType: expectedIconType1, actionToTest: cellViewModel.sheetActions[1])
        
        let expectedText2 = "Notification settings"
        let expectedURL2: URL? = nil
        let expectedIconType2: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText2, expectedURL: expectedURL2, expectedIconType: expectedIconType2, actionToTest: cellViewModel.sheetActions[2], isNotificationSettings: true)
    }
    
    private func testMentionFailureNotFoundText(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertEqual(cellViewModel.headerText, "Failed mention")
        XCTAssertEqual(cellViewModel.subheaderText, "Alert from TEST-Wikipedia", "Invalid subheaderText")
        XCTAssertEqual(cellViewModel.bodyText, "Your mention of Fredirufjdjd was not sent because the user was not found.")
        XCTAssertEqual(cellViewModel.footerText, "User talk:Jack The Cat", "Invalid footerText")
        XCTAssertEqual(cellViewModel.dateText, "1/6/22", "Invalid dateText")
        XCTAssertEqual(cellViewModel.projectText, "TEST", "Invalid projectText")
    }
    
    private func testMentionFailureNotFoundIcons(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertNil(cellViewModel.projectIconName, "Invalid projectIconName")
        XCTAssertEqual(cellViewModel.footerIconType, .personFill, "Invalid footerIconType")
    }
    
    private func testMentionFailureNotFoundActions(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertEqual(cellViewModel.sheetActions.count, 3, "Invalid sheetActionsCount")
        
        let expectedText0 = "Mark as unread"
        let expectedURL0: URL? = nil
        let expectedIconType0: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText0, expectedURL: expectedURL0, expectedIconType: expectedIconType0, actionToTest: cellViewModel.sheetActions[0], isMarkAsRead: true)
        
        let expectedText1 = "Go to User talk:Jack The Cat"
        let expectedURL1: URL? = URL(string: "https://test.wikipedia.org/wiki/User_talk:Jack_The_Cat#Section_Title")!
        let expectedIconType1: NotificationsCenterIconType? = .document
        try testActions(expectedText: expectedText1, expectedURL: expectedURL1, expectedIconType: expectedIconType1, actionToTest: cellViewModel.sheetActions[1])
        
        let expectedText2 = "Notification settings"
        let expectedURL2: URL? = nil
        let expectedIconType2: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText2, expectedURL: expectedURL2, expectedIconType: expectedIconType2, actionToTest: cellViewModel.sheetActions[2], isNotificationSettings: true)
    }
    
    private func testMentionSuccessText(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertEqual(cellViewModel.headerText, "Successful mention")
        XCTAssertEqual(cellViewModel.subheaderText, "Alert from EN-Wikipedia", "Invalid subheaderText")
        XCTAssertEqual(cellViewModel.bodyText, "Your mention of Jack The Cat was sent.")
        XCTAssertEqual(cellViewModel.footerText, "User talk:Fred The Bird", "Invalid footerText")
        XCTAssertEqual(cellViewModel.dateText, "7/16/21", "Invalid dateText")
        XCTAssertEqual(cellViewModel.projectText, "EN", "Invalid projectText")
    }
    
    private func testMentionSuccessIcons(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertNil(cellViewModel.projectIconName, "Invalid projectIconName")
        XCTAssertEqual(cellViewModel.footerIconType, .personFill, "Invalid footerIconType")
    }
    
    private func testMentionSuccessActions(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertEqual(cellViewModel.sheetActions.count, 3, "Invalid sheetActionsCount")
        
        let expectedText0 = "Mark as unread"
        let expectedURL0: URL? = nil
        let expectedIconType0: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText0, expectedURL: expectedURL0, expectedIconType: expectedIconType0, actionToTest: cellViewModel.sheetActions[0], isMarkAsRead: true)
        
        let expectedText1 = "Go to User talk:Fred The Bird"
        let expectedURL1: URL? = URL(string: "https://en.wikipedia.org/wiki/User_talk:Fred_The_Bird#Section_Title")!
        let expectedIconType1: NotificationsCenterIconType? = .document
        try testActions(expectedText: expectedText1, expectedURL: expectedURL1, expectedIconType: expectedIconType1, actionToTest: cellViewModel.sheetActions[1])
        
        let expectedText2 = "Notification settings"
        let expectedURL2: URL? = nil
        let expectedIconType2: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText2, expectedURL: expectedURL2, expectedIconType: expectedIconType2, actionToTest: cellViewModel.sheetActions[2], isNotificationSettings: true)
    }
    
    private func testMentionSuccessWikidataText(cellViewModel: NotificationsCenterCellViewModel) throws {
        
        XCTAssertEqual(cellViewModel.headerText, "Successful mention")
        XCTAssertEqual(cellViewModel.subheaderText, "Alert from Wikidata", "Invalid subheaderText")
        XCTAssertEqual(cellViewModel.bodyText, "Your mention of Jack The Cat was sent.")
        XCTAssertEqual(cellViewModel.footerText, "User talk:Fred The Bird", "Invalid footerText")
        XCTAssertEqual(cellViewModel.dateText, "7/16/21", "Invalid dateText")
        XCTAssertNil(cellViewModel.projectText, "Invalid projectText")
        
    }
    
    private func testMentionSuccessWikidataIcons(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertEqual(cellViewModel.projectIconName, "notifications-project-wikidata", "Invalid projectIconName")
        XCTAssertEqual(cellViewModel.footerIconType, .personFill, "Invalid footerIconType")
    }
    
    private func testMentionSuccessWikidataActions(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertEqual(cellViewModel.sheetActions.count, 3, "Invalid sheetActionsCount")
        
        let expectedText0 = "Mark as unread"
        let expectedURL0: URL? = nil
        let expectedIconType0: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText0, expectedURL: expectedURL0, expectedIconType: expectedIconType0, actionToTest: cellViewModel.sheetActions[0], isMarkAsRead: true)
        
        let expectedText1 = "Go to User talk:Fred The Bird"
        let expectedURL1: URL? = URL(string: "https://wikidata.org/wiki/User_talk:Fred_The_Bird#Section_Title")!
        let expectedIconType1: NotificationsCenterIconType? = .document
        try testActions(expectedText: expectedText1, expectedURL: expectedURL1, expectedIconType: expectedIconType1, actionToTest: cellViewModel.sheetActions[1])
        
        let expectedText2 = "Notification settings"
        let expectedURL2: URL? = nil
        let expectedIconType2: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText2, expectedURL: expectedURL2, expectedIconType: expectedIconType2, actionToTest: cellViewModel.sheetActions[2], isNotificationSettings: true)
    }
    
    private func testMentionInArticleTalkZhWikiquoteText(cellViewModel: NotificationsCenterCellViewModel) throws {
        
        XCTAssertEqual(cellViewModel.headerText, "Section Title", "Invalid headerText")
        XCTAssertEqual(cellViewModel.subheaderText, "From Fred The Bird", "Invalid subheaderText")
        XCTAssertEqual(cellViewModel.bodyText, "Jack The Cat Reply text mention in talk page.")
        XCTAssertEqual(cellViewModel.footerText, "Talk:Blue Bird", "Invalid footerText")
        XCTAssertEqual(cellViewModel.dateText, "3/14/22", "Invalid dateText")
        XCTAssertNil(cellViewModel.projectText, "Invalid projectText")
    }
    
    private func testMentionInArticleTalkZhWikiquoteIcons(cellViewModel: NotificationsCenterCellViewModel) throws {

        XCTAssertEqual(cellViewModel.projectIconName, "notifications-project-wikiquote", "Invalid projectIconName")
        XCTAssertEqual(cellViewModel.footerIconType, .personFill, "Invalid footerIconType")
    }
    
    private func testMentionInArticleTalkZhWikiquoteActions(cellViewModel: NotificationsCenterCellViewModel) throws {
        XCTAssertEqual(cellViewModel.sheetActions.count, 6, "Invalid sheetActionsCount")
        
        let expectedText0 = "Mark as unread"
        let expectedURL0: URL? = nil
        let expectedIconType0: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText0, expectedURL: expectedURL0, expectedIconType: expectedIconType0, actionToTest: cellViewModel.sheetActions[0], isMarkAsRead: true)
        
        let expectedText1 = "Go to Fred The Bird\'s user page"
        let expectedURL1: URL? = URL(string: "https://zh.wikiquote.org/wiki/User:Fred_The_Bird")!
        let expectedIconType1: NotificationsCenterIconType? = .person
        try testActions(expectedText: expectedText1, expectedURL: expectedURL1, expectedIconType: expectedIconType1, actionToTest: cellViewModel.sheetActions[1])
        
        let expectedText2 = "Go to diff"
        let expectedURL2: URL? = URL(string:"https://zh.wikiquote.org/w/index.php?oldid=505586&title=Talk%253ABlue_Bird")!
        let expectedIconType2: NotificationsCenterIconType? = .diff
        try testActions(expectedText: expectedText2, expectedURL: expectedURL2, expectedIconType: expectedIconType2, actionToTest: cellViewModel.sheetActions[2])
        
        let expectedText3 = "Go to Talk:Blue Bird"
        let expectedURL3: URL? = URL(string: "https://zh.wikiquote.org/wiki/Talk:Blue_Bird#Section_Title")!
        let expectedIconType3: NotificationsCenterIconType? = .document
        try testActions(expectedText: expectedText3, expectedURL: expectedURL3, expectedIconType: expectedIconType3, actionToTest: cellViewModel.sheetActions[3])
        
        let expectedText4 = "Go to Blue Bird"
        let expectedURL4: URL? = URL(string: "https://zh.wikiquote.org/wiki/Blue_Bird#Section_Title")!
        let expectedIconType4: NotificationsCenterIconType? = .document
        try testActions(expectedText: expectedText4, expectedURL: expectedURL4, expectedIconType: expectedIconType4, actionToTest: cellViewModel.sheetActions[4])
        
        let expectedText5 = "Notification settings"
        let expectedURL5: URL? = nil
        let expectedIconType5: NotificationsCenterIconType? = nil
        try testActions(expectedText: expectedText5, expectedURL: expectedURL5, expectedIconType: expectedIconType5, actionToTest: cellViewModel.sheetActions[5], isNotificationSettings: true)
    }
}
