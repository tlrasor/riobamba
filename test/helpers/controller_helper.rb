require 'minitest/autorun'
require 'rack/test'
require 'sinatra'
require 'rack/parser'
require 'multi_json'

require_relative '../../bin/app'

module Riobamba
  module Tests

    class TestFixture < Minitest::Test
      include Rack::Test::Methods

      def app
        Rack::Builder.parse_file('config.ru').first
      end

    end
  end
end

