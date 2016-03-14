namespace :DB do
  require 'dm-migrations'

  logger = Logging.logger[self]

  task :db_environment => :environment do
    if not ENV['RACK_ENV'] 
      logger.warn "NO RACK_ENV VARIABLE SET: ASSUMING :development!"
      ENV['RACK_ENV'] = 'development' 
    end
  end

  desc "migrates the db"  
  task :migrate => :db_environment do  
    @modelbootstrapper.configure().migrate
  end

  desc "upgrades the db"  
  task :upgrade => :db_environment do  
    @modelbootstrapper.upgrade
  end  

  task :add_redirect=> :db_environment do
    @modelbootstrapper.bootstrap
    url = ENV['URL']
    if url.nil?
      raise "Please specify a URL env variable"
    end
    r = Riobamba::Models::Redirect.first_or_create(:url => url)
    if not r.saved?
      raise 'Unable to save request'
    end
    logger.info "#{r}"
  end 
end