require "minitest/spec"
require "minitest/autorun"
require 'minitest/reporters'
require 'rack/parser'
require 'rack/test'

reporter_options = { color: true }
reports_dir = ENV['CIRCLE_TEST_REPORTS'] || 'tests/reports'
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options),
                          Minitest::Reporters::MeanTimeReporter.new,
                          Minitest::Reporters::JUnitReporter.new(reports_dir)
                        ]

ENV['RACK_ENV'] = 'test'
require "./config/environment"

include Rack::Test::Methods