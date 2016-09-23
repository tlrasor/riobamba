require 'data_mapper'
require 'dm-migrations'
require 'logging'
require 'path_builder'

require 'models/all'

db_path = LoadPath::PathBuilder.new(File.dirname(__FILE__)).sibling_directory('db').to_s
log = Logging.logger['DatabaseConfig']
if ENV['RACK_ENV'] == 'development'
  db_path = ENV['DB_FILE'] || db_path + "/development.db"
  log.info "Connecting to local file sqlite3 database at #{db_path}"
  DataMapper::Logger.new(log, :debug)
  DataMapper.setup(:default,"sqlite3://#{db_path}")
  DataMapper.auto_upgrade!
end 

if ENV['RACK_ENV'] =='test'
  log.info "Setting up in memory sqlite3 database"
  DataMapper::Logger.new(log, :info)
  DataMapper.setup(:default,"sqlite3::memory:")
  log.info "Auto migrating database"
  DataMapper.auto_migrate!
end

DataMapper.finalize
DataMapper::Model.raise_on_save_failure = true