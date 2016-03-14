require_relative './bin/app_logging'

rake_files = FileList['rake/*.rake']
if ENV["DEBUG"]
  puts "Using rake files: #{rake_files}"
end
rake_files.each { |r| load r }