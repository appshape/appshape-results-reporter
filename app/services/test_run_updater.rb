class TestRunUpdater
  def initialize(test_run_id)
    @test_run_id = test_run_id
  end

  def update(results)
    results.each do |result|
      update_test_run_with_results(TestRunResult.from_json(result))
    end
  end

  def update_test_run_with_results(test_run_result)
    DatabaseConnection.instance.connection.query(query, parameters(test_run_result))
  end

  def async_update_test_run_with_results(test_run_result)
    DatabaseConnection.instance.send_query(query, parameters(test_run_result))
  end

  private
  def query
    <<-SQL
      update
        test_runs
      set
        result = $1::boolean,
        failed_assertions = $2::json,
        response_body_file_path = $3::varchar,
        executed_at = cast($4 as timestamp with time zone)
      where
        id = $5::int
    SQL
  end

  def parameters(test_run_result)
    [
        test_run_result.result,
        test_run_result.failed_assertions.to_json,
        test_run_result.response_body_file_path,
        test_run_result.executed_at,
        test_run_result.id
    ]
  end
end