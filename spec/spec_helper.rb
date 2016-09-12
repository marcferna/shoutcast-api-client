$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'shoutcast/api'
require 'codeclimate-test-reporter'
require 'simplecov-json'
require 'simplecov'

CodeClimate::TestReporter.start
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::JSONFormatter,
    CodeClimate::TestReporter::Formatter
  ]
)

SimpleCov.start
