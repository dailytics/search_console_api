require "test_helper"

class QueryTest < Minitest::Test
  def test_initialize_and_to_json
    query = SearchConsoleApi::Query.new(
      start_date: "2017-01-01",
      end_date: "2017-01-31",
      dimensions: %w[query page],
      row_limit: 1000
    )

    expected_json = {
      startDate: "2017-01-01",
      endDate: "2017-01-31",
      dimensions: %w[query page],
      rowLimit: 1000
    }.to_json

    assert_equal expected_json, query.to_json
  end
end
