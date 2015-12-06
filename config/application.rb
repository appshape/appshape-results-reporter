require 'bundler'
Bundler.require

require 'time'

ENV['RESULTS_REPORTER_ENV'] ||= 'development'

Dotenv.load(".env.#{ENV['RESULTS_REPORTER_ENV']}")

#models
load File.expand_path('../../app/models/test_run_result.rb', __FILE__)

#services
load File.expand_path('../../app/services/database_connection.rb', __FILE__)
load File.expand_path('../../app/services/test_run_updater.rb', __FILE__)
