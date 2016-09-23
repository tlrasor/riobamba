# encoding: UTF-8

require "rubygems"
require "bundler"
Bundler.require(:default)                   
Bundler.require(Sinatra::Base.environment)  

require 'load_path'

LoadPath.configure do
  add sibling_directory('lib')
  add sibling_directory('config')
end

require 'logging.cfg'
require 'db'
require 'controllers/redirects_controller'
require 'controllers/redirects_api_controller'