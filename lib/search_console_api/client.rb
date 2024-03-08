# frozen_string_literal: true

module SearchConsoleApi
  class Client

    attr_accessor :access_token

    def initialize(access_token)
      @access_token = access_token
    end

    def sites
      @sites ||= SearchConsoleApi::Site.parse_list(get("/sites"))
    end

    def run_query(site, query)

    end

    private

    def get(path, params = {})
      Request.get(access_token: @access_token, path: path, params: params).body
    end

  end
end