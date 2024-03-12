require "test_helper"
require "minitest/mock"
require "ostruct"

class ResourcesSearchAnalyticsQueryTest < Minitest::Test
  def setup
    @success_response_no_dimensions = OpenStruct.new({"rows" => [
      {"keys" => [""], "clicks" => 8, "impressions" => 180, "ctr" => 0.05, "position" => 3.5},
      {"keys" => [""], "clicks" => 7, "impressions" => 180, "ctr" => 0.04, "position" => 4.7},
      {"keys" => [""], "clicks" => 6, "impressions" => 180, "ctr" => 0.03, "position" => 16.71111111111111}
    ]})
    @success_response_query_date_dimensions = OpenStruct.new({"rows" => [
      {"keys" => ["foo", "2024-03-01"], "clicks" => 8, "impressions" => 180, "ctr" => 0.05, "position" => 3.5},
      {"keys" => ["foo", "2024-03-02"], "clicks" => 7, "impressions" => 180, "ctr" => 0.04, "position" => 4.7},
      {"keys" => ["bar", "2024-03-01"], "clicks" => 6, "impressions" => 180, "ctr" => 0.03, "position" => 16}
    ]})
  end

  def test_call_with_no_dimensions
    api = SearchConsoleApi::Resources::SearchAnalytics::Query.new(access_token: "abcd", start_date: "2024-03-01", end_date: "2024-04-01")
    api.stub(:response, @success_response_no_dimensions) do
      rows = api.call
      assert_equal 3, rows.length
      assert_equal [""], rows.first.keys
      assert_equal 8, rows.first.clicks
      assert_equal 180, rows.first.impressions
      assert_equal 16.71111111111111, rows.last.position
      assert_nil rows.first.query
    end
  end

  def test_call_with_query_and_date_dimensions
    api = SearchConsoleApi::Resources::SearchAnalytics::Query.new(access_token: "abcd", start_date: "2024-03-01", end_date: "2024-04-01", dimensions: ["query", "date"])
    api.stub(:response, @success_response_query_date_dimensions) do
      rows = api.call
      assert_equal 3, rows.length
      assert_equal ["foo", "2024-03-01"], rows.first.keys
      assert_equal "foo", rows.first.query
      assert_equal "2024-03-01", rows.first.date
      assert_nil rows.first.device
    end
  end

  def test_call_with_site_object
    site = SearchConsoleApi::Objects::Site.new({"siteUrl" => "https://example.com"})
    api = SearchConsoleApi::Resources::SearchAnalytics::Query.new(access_token: "abcd", site: site, start_date: "2024-03-01", end_date: "2024-04-01")
    assert_equal "/sites/https%3A%2F%2Fexample.com/searchAnalytics/query", api.request_path
  end

  def test_call_with_site_url
    api = SearchConsoleApi::Resources::SearchAnalytics::Query.new(access_token: "abcd", site: "https://example.com", start_date: "2024-03-01", end_date: "2024-04-01")
    assert_equal "/sites/https%3A%2F%2Fexample.com/searchAnalytics/query", api.request_path
  end
end
