$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'shoutcast/api'
require 'simplecov-json'
require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::JSONFormatter
  ]
)

SimpleCov.start
