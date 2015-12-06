require_relative '../test_helper'

describe TestRunResult do
  describe 'TestRunResult.from_json' do
    let(:current_time) { Time.now.iso8601 }
    let(:failed_assertions) { [] }
    before do
      @data = {
        'run_id' => 12,
        'failed_assertions' => failed_assertions,
        's3_object_name' => 'some_file_path.txt',
        'executed_at' => current_time
      }
    end

    it 'must return new TestRunResult object' do
      TestRunResult.from_json(@data).is_a?(TestRunResult).must_equal true
    end

    it 'must assign correctly all attributes' do
      object = TestRunResult.from_json(@data)

      object.id.must_equal @data['run_id']
      object.failed_assertions.must_equal @data['failed_assertions']
      object.response_body_file_path.must_equal @data['s3_object_name']
      object.executed_at.must_equal @data['executed_at']
    end

    describe 'when there is no failed assertions' do
      it 'must assign result correctly' do
        object = TestRunResult.from_json(@data)
        object.result.must_equal true
      end
    end

    describe 'when there are failed assertions' do
      let(:failed_assertions) { [{ source_code: 1 }] }
      it 'must assign result correctly' do
        object = TestRunResult.from_json(@data)
        object.result.must_equal false
      end
    end
  end
end