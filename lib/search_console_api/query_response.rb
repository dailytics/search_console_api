# frozen_string_literal: true

require 'json'
require 'date'

module SearchConsoleApi
  class QueryResponse

    attr_accessor :body, :raw_dimension_headers, :raw_metric_headers, :rows, :row_count, :metadata, :kind

    def initialize(body)
      @body = JSON.parse body
      @raw_dimension_headers = @body["dimensionHeaders"] || []
      @raw_metric_headers = @body["metricHeaders"] || []
      @rows = @body["rows"] || []
      @row_cont = @body["rowCount"] || 0
      @metadata = @body["metadata"]
      @kind = @body["kind"]
    end

    def dimension_headers
      @dimension_headers ||= @raw_dimension_headers.map { |header| header["name"] }
    end

    def metric_headers
      @metric_headers ||= @raw_metric_headers.map { |header| header["name"] }
    end

    def parsed_rows
      @rows.map do |row|
        ReportResponseRow.new(row, @raw_dimension_headers, @raw_metric_headers)
      end
    end

  end
end