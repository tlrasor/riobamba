require 'minitest/autorun'
require 'rack/test'
require 'sinatra'
require 'rack/parser'
require 'multi_json'

ENV['RACK_ENV'] = 'test'
require_relative '../bin/app'

module Riobamba
  module Tests
    TEST_APP = Rack::Builder.parse_file('config.ru').first

    class TestFixture < Minitest::Test
      include Rack::Test::Methods

      def app
        TEST_APP
      end

    end
  end
end

