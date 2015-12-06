class TestRunResult
  attr_accessor :id,
                :result,
                :failed_assertions,
                :response_body_file_path,
                :executed_at

  def self.from_json(data)
    TestRunResult.new.tap do |run|
      run.id = data['run_id']
      run.result = data['failed_assertions'].nil? || data['failed_assertions'].empty?
      run.failed_assertions = data['failed_assertions']
      run.response_body_file_path = data['s3_object_name']
      run.executed_at = data['executed_at']
    end
  end
end