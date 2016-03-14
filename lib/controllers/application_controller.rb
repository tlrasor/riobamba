require 'sinatra/base'
require_relative 'base_controller'
require_relative '../helpers/template_helpers'

module Riobamba
  module Controllers
    class ApplicationController < BaseController

      helpers Sinatra::Riobamba::TemplateHelpers

      not_found do
        title 'Not found'
        erb :not_found
      end
    end
  end
end