require "test_helper"
require "minitest/mock"
require "ostruct"

class ResourcesSitesListTest < Minitest::Test
  def setup
    @success_response_one_site = OpenStruct.new({"siteEntry" => [
      {"siteUrl" => "https://example.com", "permissionLevel" => "siteOwner"}
    ]})
    @success_response_two_sites = OpenStruct.new({"siteEntry" => [
      {"siteUrl" => "https://example.com", "permissionLevel" => "siteOwner"},
      {"siteUrl" => "https://example2.com", "permissionLevel" => "siteOwner"}
    ]})
  end

  def test_call_with_one_site
    api = SearchConsoleApi::Resources::Sites::List.new(access_token: "abcd")
    api.stub(:response, @success_response_one_site) do
      sites = api.call
      assert_equal "https://example.com", sites.first.site_url
      assert_equal "siteOwner", sites.first.permission_level
    end
  end

  def test_call_with_two_sites
    api = SearchConsoleApi::Resources::Sites::List.new(access_token: "abcd")
    api.stub(:response, @success_response_two_sites) do
      sites = api.call
      assert_equal "https://example.com", sites.first.site_url
      assert_equal "siteOwner", sites.first.permission_level
      assert_equal "https://example2.com", sites.last.site_url
      assert_equal "siteOwner", sites.last.permission_level
    end
  end
end
