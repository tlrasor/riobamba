require 'sinatra/base'
require_relative 'api_controller'
require_relative '../helpers/code_helpers'

module Riobamba
  module Controllers
    class RedirectsController < ApiController

      helpers Sinatra::Riobamba::CodeHelpers

      get '/r/:code' do |code|
        begin
          @log.debug { params.inspect }
          id = toId(code)
          r = Models::Redirect.first(:id => id)
          if r.nil?
            not_found
          end
          redirect to(r.url)
        rescue
          halt 500
        end
      end
    end
  end
end