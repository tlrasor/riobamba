require 'sinatra/base'
require 'tilt/erb'
require 'logging'

module Riobamba
  module Controllers
    class BaseController < Sinatra::Base
      configure do
        set :app_file, __FILE__
        set :root, File.dirname(__FILE__)
        set :public_folder, Proc.new {  
          ENV['PUBLIC_FOLDER'] || File.join(root, "../public")
        }
        set :views, Proc.new {  
          ENV['VIEWS'] || File.join(root, "../templates")
        }
        set :bind, lambda { ENV['BIND_ADDRESS'] || '0.0.0.0' }
        set :port, lambda { ENV['PORT'] || '8080'}  

        disable :method_override
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

    end
  end
end