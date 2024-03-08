# frozen_string_literal: true

require "net/http"
require "uri"

module SearchConsoleApi
  class Request

    BASE_URL = "https://www.googleapis.com/webmasters/v3"

    def self.get(access_token:, path:, params: {})
      url = "#{BASE_URL}#{path}"
      url += "?#{URI.encode_www_form params}" unless params.empty?
      uri = URI(url)

      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
        request = Net::HTTP::Get.new uri
        request["Authorization"] = "Bearer #{access_token}"
        request["Content-Type"] = "application/json"

        http.request request
      end
      raise SearchConsoleApi::Error.new(response) unless response.is_a?(Net::HTTPSuccess)

      response
    end

    def self.post(access_token:, path:, payload: nil)
      url = URI("#{BASE_URL}#{path}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Bearer #{access_token}"
      request["Content-Type"] = "application/javascript"
      request.body = payload

      response = https.request(request)
      raise SearchConsoleApi::Error.new(response) unless response.is_a?(Net::HTTPSuccess)

      response.read_body
    end

  end
end
