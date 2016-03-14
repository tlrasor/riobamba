require 'sinatra/base'
require_relative 'application_controller'

module Riobamba
  module Controllers 
    class AdminController < ApplicationController

      def self.new(*)
        app = Rack::Auth::Digest::MD5.new(super) do |username|
          {'foo' => 'bar'}[username]
        end
        app.realm = 'Protected Area'
        app.opaque = 'secretkey'
        app
      end

      get '/admin' do
        title "Admin"
        #css :picnic
        css :milligram, :milligram_font
        css :font_awesome
        js :jquery
        js 'javascripts/riobamba'
        erb :admin
      end
    end
  end
end 