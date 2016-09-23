require 'sinatra/base'
require 'tilt/erb'
require 'logging'
require 'path_builder'
require "sinatra/reloader"

require 'helpers/template_helpers'

module Riobamba
  module Controllers
    class BaseController < Sinatra::Base

      def self.public_path
        path = ENV['PUBLIC_FOLDER'] 
        path ||= LoadPath::PathBuilder.new(File.dirname(__FILE__)).parent_directory('lib').sibling_directory('public').to_s
        return path
      end

      def self.view_path
        path = ENV['VIEW_FOLDER'] 
        path ||= LoadPath::PathBuilder.new(File.dirname(__FILE__)).sibling_directory('views').to_s
        return path
      end

      configure do
        set :app_file, __FILE__
        set :root, File.dirname(__FILE__)
        set :public_folder, Proc.new { public_path }
        set :views, Proc.new { view_path }
        
        disable :method_override
        enable :sessions

        helpers TemplateHelpers
        
      end

      configure :development do 
        enable :show_exceptions
        enable :dump_errors
        register Sinatra::Reloader
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