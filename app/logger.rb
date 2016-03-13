require 'logging'

class Logger
  include Singleton

  def initialize
    layout = Logging.layouts.pattern(pattern: "[%d] %-5l [%c]: %m\n")

    @logger = Logging.logger['appshape-results-reporter']
    @logger.add_appenders Logging.appenders.stdout({ layout: layout }) if ENV['APPLICATION_ENV'] == 'development'
    @logger.add_appenders Logging.appenders.file('log/appshape-results-reporter.log', { layout: layout })
  end

  def method_missing(method, *args)
    if @logger.respond_to?(method)
      @logger.send(method, *args)
    else
      super
    end
  end
end