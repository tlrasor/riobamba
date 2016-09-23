require 'dotenv/tasks'
require 'logging'
require 'load_path'

LoadPath.configure do
    add child_directory('lib')
    add child_directory('config')
end

logger = Logging.logger['Rake']

task :environment => [:dotenv] do
  logger.info "In environment"
end

rake_files = FileList['rake/*.rake']
if ENV["DEBUG"]
  logger.info "Using rake files: #{rake_files}"
end
rake_files.each { |r| load r }

task :default => ["Test:all"]