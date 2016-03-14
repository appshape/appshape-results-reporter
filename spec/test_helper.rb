require 'minitest/autorun'
require 'json'

ENV['RESULTS_REPORTER_ENV'] = 'test'

require_relative '../config/application'
require_relative 'support/database_helpers'

DatabaseHelpers.create_structure