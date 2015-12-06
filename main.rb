require "#{File.dirname(__FILE__)}/config/application.rb"

@beanstalk = Beaneater.new(ENV['BEANSTALKD_URL'])
@beanstalk.jobs.register('test-results') do |job|
  TestRunUpdater.new(job.delete('run_id')).update(job)
end

@beanstalk.jobs.process!