require 'data_mapper'
require 'dm-migrations'
require 'logging'
require_relative './init'

module Riobamba
  module Models
    class ModelBootstrapper

      def initialize
        @bootstrapped = false
        @configured = false
        @log = Logging.logger[self]
      end

      def configure
        return self unless not @configured
        if ENV['RACK_ENV'] == 'development'
          db_path = ENV['DB_FILE'] || "#{Dir.pwd}/db/development.db"
          @log.info "Connecting to local file sqlite3 database at #{db_path}"
          DataMapper::Logger.new(@log, :debug)
          DataMapper.setup(:default,"sqlite3://#{db_path}")
        end 

        if ENV['RACK_ENV'] =='test'
          @log.info "Setting up in memory sqlite3 database"
          DataMapper::Logger.new(@log, :info)
          DataMapper.setup(:default,"sqlite3::memory:")
          migrate
        end
        @configured = true
        self
      end

      def bootstrap
        if not @bootstrapped
          @log.info "Bootstrapping DB models and connections"
          configure unless @configured
          DataMapper.finalize
          @bootstrapped = true
        end
      self
      end

      def upgrade
        @log.info "Auto upgrading database"
        DataMapper.auto_upgrade!
      end

      def migrate
        @log.info "Auto migrating database"
        DataMapper.auto_migrate!
      end
    end
  end
end
