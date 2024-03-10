# frozen_string_literal: true

module SearchConsoleApi
  class Client

    attr_accessor :access_token

    def initialize(access_token)
      @access_token = access_token
    end

    def sites
      @sites ||= Resources::Sites::List.new(access_token: @access_token).call
    end

    def query(site:, start_date:, end_date:, dimensions: [], type: nil, dimension_filter_groups: [], aggregation_type: nil, row_limit: nil, start_row: nil, data_state: nil)
      Resources::SearchAnalytics::Query.new(
        access_token: @access_token, site: site, start_date: start_date, end_date: end_date,
        dimensions: dimensions, type: type, dimension_filter_groups: dimension_filter_groups,
        aggregation_type: aggregation_type, row_limit: row_limit, start_row: start_row,
        data_state: data_state
      ).call
    end
  end
end