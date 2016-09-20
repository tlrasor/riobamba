require 'dotenv/tasks'
require_relative './config/logging'

logger = Logging.logger['Rake']

task :environment => [:dotenv] do
  logger.debug "#{ENV}"
end

rake_files = FileList['rake/*.rake']
if ENV["DEBUG"]
  logger.info "Using rake files: #{rake_files}"
end
rake_files.each { |r| load r }

task :default => ["Test:all"]