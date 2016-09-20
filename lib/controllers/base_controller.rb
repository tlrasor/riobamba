require 'sinatra/base'
require 'tilt/erb'
require 'logging'
require_relative '../helpers/template_helpers'

module Riobamba
  module Controllers
    class BaseController < Sinatra::Base
      configure do
        set :app_file, __FILE__
        set :root, File.dirname(__FILE__)
        set :public_folder, Proc.new {  
          ENV['PUBLIC_FOLDER'] || File.expand_path("../public", root)
        }
        set :views, Proc.new {  
          ENV['VIEWS'] || File.expand_path("../views", root)
        }
        set :bind, lambda { ENV['BIND_ADDRESS'] || '0.0.0.0' }
        set :port, lambda { ENV['PORT'] || '8080'}  

        disable :method_override
        enable :sessions

        helpers Sinatra::Riobamba::TemplateHelpers
        
      end

      configure :development do 
        enable :show_exceptions
        enable :dump_errors
      end

      configure :production do
        disable :show_exceptions
        enable :dump_errors
      end

      def initialize *args
        @log = Logging.logger[self]
        super *args
      end

      not_found do
        title 'Not found'
        erb :not_found
      end

    end
  end
end