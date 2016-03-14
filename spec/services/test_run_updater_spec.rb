require_relative '../test_helper'

describe TestRunUpdater do
  describe 'TestRunUpdater#update_test_run_with_results' do
    DatabaseHelpers.insert_test_run

    before do
      @test_run_result = TestRunResult.new.tap do |object|
        object.result = false
        object.failed_assertions = [{'source_code' => 'test_field'}]
        object.response_body_file_path = 'some_file.txt'
        object.executed_at = Time.now.iso8601
      end
    end

    it 'updates database entry with given data' do
      TestRunUpdater.new(1).update_test_run_with_results(@test_run_result)

      row = DatabaseHelpers.select_test_run(@test_run_result.id)

      row['result'].must_equal 'f'
      JSON.parse(row['failed_assertions']).must_equal @test_run_result.failed_assertions
      row['response_body_file_path'].must_equal @test_run_result.response_body_file_path
      Time.parse(row['executed_at']).must_equal Time.parse(@test_run_result.executed_at)
    end
  end
end