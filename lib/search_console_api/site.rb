# frozen_string_literal: true

require "json"

module SearchConsoleApi
  class Site
    attr_accessor :site_url, :permission_level

    def initialize(attributes = {})
      attributes.each do |k, v|
        snake_case_key = k.gsub(/([a-z])([A-Z])/, '\1_\2').gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').downcase
        send("#{snake_case_key}=", v)
      end
    end

    def self.parse_list(body)
      parsed_body = JSON.parse(body)
      return [] if parsed_body["siteEntry"].nil?

      parsed_body["siteEntry"].map do |attrs|
        Site.new(attrs)
      end
    end
  end
end
