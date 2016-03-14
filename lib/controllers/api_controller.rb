require 'sinatra/base'
require 'rack/parser'
require 'multi_json'
require_relative 'base_controller'
require_relative '../models/model_bootstrapper'
require_relative '../helpers/json_helpers'

module Riobamba
  module Controllers
    class ApiController < Controllers::BaseController

      helpers Sinatra::Riobamba::JsonHelpers

      before do
        content_type 'application/json'
      end
      
      not_found do
        status 404
        halt to_json({ :status => 'not_found'})
      end
    end
  end
end