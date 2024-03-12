require "date"

module SearchConsoleApi
  module Resources
    module SearchAnalytics
      class Query
        def initialize(access_token:, site: nil, start_date: nil, end_date: nil, dimensions: [], type: nil, dimension_filter_groups: [], aggregation_type: nil, row_limit: nil, start_row: nil, data_state: nil)
          @access_token = access_token
          @site = site
          @start_date = DateTime.parse(start_date.to_s).strftime("%Y-%m-%d")
          @end_date = DateTime.parse(end_date.to_s).strftime("%Y-%m-%d")
          @dimensions = dimensions
          @type = type
          @dimension_filter_groups = dimension_filter_groups
          @aggregation_type = aggregation_type
          @row_limit = row_limit
          @start_row = start_row
          @data_state = data_state

          unless @site.is_a?(SearchConsoleApi::Objects::Site)
            @site = SearchConsoleApi::Objects::Site.new({"siteUrl" => @site})
          end
        end

        def call
          response["rows"].each_with_object([]) do |attrs, rows|
            rows << Objects::QueryResponseRow.new(attrs, @dimensions)
          end
        end

        def request_path
          "/sites/#{@site.encoded_site_url}/searchAnalytics/query"
        end

        private

        def response
          Request.post(
            access_token: @access_token,
            path: request_path,
            payload: payload
          )
        end

        def payload
          output = {
            startDate: @start_date,
            endDate: @end_date
          }
          output[:dimensions] = @dimensions if @dimensions.any?
          output[:type] = @type if @type
          output[:dimensionFilterGroups] = @dimension_filter_groups if @dimension_filter_groups.any?
          output[:aggregationType] = @aggregation_type if @aggregation_type
          output[:rowLimit] = @row_limit if @row_limit
          output[:startRow] = @start_row if @start_row
          output[:dataState] = @data_state if @data_state
          output.to_json
        end
      end
    end
  end
end
