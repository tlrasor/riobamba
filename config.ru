if ENV['RACK_ENV'] != 'production'
  require 'dotenv'
  Dotenv.load
end

require 'rack'
require 'rack/parser'
require 'multi_json'

require './config/environment'

use Rack::Deflater
use Rack::Parser, :parsers => { 
  'application/json' => proc {|data|  MultiJson.load(data, :symbolize_keys => true)}
}

map '/api' do
  run Riobamba::Controllers::RedirectsApiController.new
end

map '/' do
  run Riobamba::Controllers::RedirectsController.new
end