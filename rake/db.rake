namespace :DB do
  require 'dm-migrations'
  require './lib/models/model_bootstrapper'

  logger = Logging.logger[self]

  if not ENV['RACK_ENV'] 
    logger.info "NO RACK_ENV VARIABLE SET: ASSUMING :development!"
    ENV['RACK_ENV'] = 'development' 
  end

  task :environment do
    @modelbootstrapper = Riobamba::Models::ModelBootstrapper.new().configure()
  end

  desc "migrates the db"  
  task :migrate => :environment do  
    @modelbootstrapper.configure().migrate
  end

  desc "upgrades the db"  
  task :upgrade => :environment do  
    @modelbootstrapper.upgrade
  end  

  task :add_redirect=> :environment do
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