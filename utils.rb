require 'open3'

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
