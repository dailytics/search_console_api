require "test_helper"

class SiteTest < Minitest::Test
  def test_parse_list_with_one_site
    list = SearchConsoleApi::Site.parse_list('{"siteEntry": [{"siteUrl": "http://example.com/", "permissionLevel": "siteOwner"}]}')
    assert_equal list.first.site_url, "http://example.com/"
    assert_equal list.first.permission_level, "siteOwner"
  end

  def test_parse_list_with_two_sites
    list = SearchConsoleApi::Site.parse_list('{"siteEntry": [{"siteUrl": "http://example.com/", "permissionLevel": "siteOwner"}, {"siteUrl": "http://example2.com/", "permissionLevel": "siteOwner"}]}')
    assert_equal list.first.site_url, "http://example.com/"
    assert_equal list.last.site_url, "http://example2.com/"
  end
end
