require 'dm-migrations'
require './config/db'

namespace :DB do

  logger = Logging.logger['Rake']

  task :db_environment => :environment do
    if not ENV['RACK_ENV'] 
      logger.warn "NO RACK_ENV VARIABLE SET: ASSUMING :development!"
      ENV['RACK_ENV'] = 'development' 
    end
  end 

  task :add_redirect=> :db_environment do
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