# encoding: UTF-8
require 'dotenv'
Dotenv.load unless ENV['RACK_ENV'] == 'production'

require_relative './app_logging'

require_relative '../lib/models/model_bootstrapper'
Riobamba::Models::ModelBootstrapper.new().bootstrap()

require_relative '../lib/controllers/index_controller'
require_relative '../lib/controllers/redirects_controller'
require_relative '../lib/controllers/redirects_api_controller'
require_relative '../lib/controllers/admin_controller'