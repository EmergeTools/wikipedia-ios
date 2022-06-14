require 'open3'
require 'json'

def sh!(args, allow_failure: false, get_output: false, chdir: Dir.pwd)
  raise "Wrong type: #{args.class}" unless args.is_a?(Array)
  raise 'args.size must be > 1 (or it would be spawned in a subshell)' if args.size <= 1
  if get_output
    stdout, stderr, result = Open3.capture3(*args, chdir: chdir)
    puts "Stderr:\n#{stderr}" if stderr.length > 0
    success = result.success?
  else
    success = system(*args, chdir: chdir)
    stdout = stderr = nil
  end
  raise "Command failed: #{args}" unless success || allow_failure
  [stdout, stderr, success]
end

data = {"filename": "Wikipedia.xcarchive.zip", "repoName": "wikipedia-ios", "buildType": "main", "sha": "3845715a3be9876974345da41a0e0fb0500c53a0"}
token = IO.read(File.expand_path("~/api_token")).chomp
url = "https://api.emergetools.com/upload"
url, _ = sh!(%W[curl --request POST --url #{url} --header #{'Accept: application/json'} --header #{'Content-Type: application/json'} --header #{"X-API-Token: #{token}"} --data #{data.to_json}], get_output: true)
puts url
sh!(%W[curl -v -H #{'Content-Type: application/zip'} -T Wikipedia.xcarchive.zip])
