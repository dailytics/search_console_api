# frozen_string_literal: true

require "json"
require "uri"

module SearchConsoleApi
  module Objects
    class Site
      attr_accessor :site_url, :permission_level

      def initialize(attributes = {})
        @site_url = attributes["siteUrl"]
        @permission_level = attributes["permissionLevel"]
      end

      def encoded_site_url
        URI.encode_www_form_component(@site_url)
      end
    end
  end
end