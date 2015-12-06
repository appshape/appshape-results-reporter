require 'singleton'

class DatabaseConnection
  include Singleton

  attr_reader :connection

  def initialize
    @connection = PG::Connection.new(
      host: ENV['DATABASE_HOST'],
      port: ENV['DATABASE_PORT'],
      user: ENV['DATABASE_USER'],
      password: ENV['DATABASE_PASSWORD'],
      dbname: ENV['DATABASE_NAME']
    )
  end
end