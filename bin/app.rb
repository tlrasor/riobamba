# encoding: UTF-8

if ENV['RACK_ENV'] = 'production'
  require 'dotenv'
  Dotenv.load
end

require_relative '../config/logging'
require_relative '../config/db'

require_relative '../lib/controllers/redirects_controller'
require_relative '../lib/controllers/redirects_api_controller'