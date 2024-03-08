# frozen_string_literal: true

require "json"
require "date"

module SearchConsoleApi
  class Query
    attr_accessor :start_date, :end_date, :dimensions, :type,
      :dimension_filter_groups, :aggregation_type, :row_limit,
      :start_row, :data_state

    def initialize(start_date: nil, end_date: nil, dimensions: [], type: nil, dimension_filter_groups: [], aggregation_type: nil, row_limit: nil, start_row: nil, data_state: nil)
      @start_date = start_date
      @end_date = end_date
      @dimensions = dimensions
      @type = type
      @dimension_filter_groups = dimension_filter_groups
      @aggregation_type = aggregation_type
      @row_limit = row_limit
      @start_row = start_row
      @data_state = data_state
    end

    def to_json
      output = {}
      output[:startDate] = @start_date if @start_date
      output[:endDate] = @end_date if @end_date
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
