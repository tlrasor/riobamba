require 'dotenv/tasks'
require_relative './bin/app_logging'
require_relative './lib/models/model_bootstrapper'

logger = Logging.logger.root

task :environment => [:dotenv] do
  @modelbootstrapper = Riobamba::Models::ModelBootstrapper.new().configure()
end

rake_files = FileList['rake/*.rake']
if ENV["DEBUG"]
  logging.info "Using rake files: #{rake_files}"
end
rake_files.each { |r| load r }

task :default => ["Test:all"]