require "minitest/spec"
require "minitest/autorun"
require 'minitest/reporters'
require 'rack/parser'
require 'rack/test'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options),
                          Minitest::Reporters::MeanTimeReporter.new]

ENV['RACK_ENV'] = 'test'
require "./config/environment"

include Rack::Test::Methods