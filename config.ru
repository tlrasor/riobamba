require 'rack'
require 'rack/parser'
require 'multi_json'

require './bin/app'

use Rack::Deflater
use Rack::Parser, :parsers => { 
  'application/json' => proc {|data|  MultiJson.load(data, :symbolize_keys => true)}
}
run Rack::Cascade.new([
  Riobamba::Controllers::RedirectsController,
  Riobamba::Controllers::RedirectsApiController
])