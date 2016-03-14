require 'sinatra/base'
require_relative 'application_controller'

module Riobamba
  module Controllers 
    class IndexController < ApplicationController

      get '/' do
        css :picnic
        js :jquery
        erb :index
      end
    end
  end
end 