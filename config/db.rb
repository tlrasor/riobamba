require 'data_mapper'
require 'dm-migrations'
require 'logging'

require_relative '../lib/models/all'

log = Logging.logger['DatabaseConfig']
if ENV['RACK_ENV'] == 'development'
  db_path = ENV['DB_FILE'] || "../../db/development.db"
  log.info "Connecting to local file sqlite3 database at #{db_path}"
  DataMapper::Logger.new(log, :debug)
  DataMapper.setup(:default,"sqlite3://#{db_path}")
end 

if ENV['RACK_ENV'] =='test'
  log.info "Setting up in memory sqlite3 database"
  DataMapper::Logger.new(log, :info)
  DataMapper.setup(:default,"sqlite3::memory:")
  log.info "Auto migrating database"
  DataMapper.auto_migrate!
end

DataMapper.finalize