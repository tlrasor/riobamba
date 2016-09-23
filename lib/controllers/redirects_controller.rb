require 'sinatra/base'

require 'controllers/base_controller'
require 'services/redirect_service'

module Riobamba
  module Controllers 
    class RedirectsController < BaseController

      get '/' do 
       css "https://cdn.jsdelivr.net/picnicss/6.1.4/picnic.min.css"
       
        css '/css/riobamba.css'
        js :jquery
        js 'javascripts/riobamba.js'
        erb :index
      end

      get '/:code/*' do
        @log.debug { params.inspect }
        @code = params['code']  
        @params = params
        title 'Redirecting you...'
        css :picnic
        css '/css/riobamba.css'
        js :jquery
        erb :redirect
      end
    end
  end
end