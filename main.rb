require "#{File.dirname(__FILE__)}/config/application.rb"

@beanstalk = Beaneater.new(ENV['BEANSTALKD_URL'])

Logger.instance.debug "results queue url #{ENV['BEANSTALKD_URL']}"

@beanstalk.jobs.register('test-results') do |job|
  data = JSON.parse(job.body)

  Logger.instance.info "[TR #{data['run_id']}] updating results"
  TestRunUpdater.new(data['run_id']).update(data['results'])
end

@beanstalk.jobs.process!