require 'sinatra/base'
require 'multi_json'

require_relative 'base_controller'
require_relative '../services/redirect_service'

module Riobamba
  module Controllers 
    class RedirectsController < BaseController

      get '/r/:code' do |code|
        begin
          @log.debug { params.inspect }
          r = Services::RedirectService.getByCode(code)
          if r.nil?
            not_found
          end
          r.update(:uses => r.uses+1)
          erb :redirect
        rescue
          halt 500
        end
      end
    end
  end
end