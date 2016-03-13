ENV['APPLICATION_ENV'] ||= 'development'

require 'bundler'
Bundler.require(:default, ENV['APPLICATION_ENV'])

require 'time'

Dotenv.load

load File.expand_path('../../app/logger.rb', __FILE__)

#models
load File.expand_path('../../app/models/test_run_result.rb', __FILE__)

#services
load File.expand_path('../../app/services/database_connection.rb', __FILE__)
load File.expand_path('../../app/services/test_run_updater.rb', __FILE__)
