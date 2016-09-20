require_relative '../helpers/controller_helper'

require 'controllers/redirects_api_controller'
require 'json'

module Riobamba
  module Tests
    class RedirectsApiControllerTest < TestFixture

      # def setup
      #   @log = Logging.logger[self]
      #   url = "http://something.org/something?=12asd"
      #   r = Models::Redirect.create(:url => url)
      # end

      # def test_get
      #   get '/api/r'
      #   assert last_response.ok?
      #   assert last_response.length >=1
      # end

      # def test_post
      #   data = { :url => "http://test.co" }
      #   post '/api/r', :body => data.to_json, 'Content-Type' => 'application/json'
      #   assert last_response.status == 201, "Status code was not 201"
      # end

    end
  end
end