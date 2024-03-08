# frozen_string_literal: true

require 'json'
require 'date'

module SearchConsoleApi
  class QueryResponseRow

    attr_accessor :data

    def initialize(row, raw_dimension_headers, raw_metric_headers)
      # "dimensionHeaders"=>[{"name"=>"pagePath"}, {"name"=>"countryId"}],
      # "metricHeaders"=>[{"name"=>"sessions", "type"=>"TYPE_INTEGER"}, {"name"=>"screenPageViews", "type"=>"TYPE_INTEGER"}],
      # a row: {"dimensionValues"=>[{"value"=>"/events"}, {"value"=>"CL"}], "metricValues"=>[{"value"=>"62"}, {"value"=>"82"}]}
      @raw_row = row
      @data = {}
      raw_dimension_headers.each_with_index do |dimension_header, index|
        @data[dimension_header["name"]] = row["dimensionValues"][index]["value"]
      end
      raw_metric_headers.each_with_index do |metric_header, index|
        @data[metric_header["name"]] = cast(row["metricValues"][index]["value"], metric_header["type"])
      end
    end

    def cast(value, type)
      words = type.split("_")
      return value unless words[0] == 'TYPE'
      return value.to_i if words[1] == "INTEGER"
      return value.to_f if words[1].in? %w(FLOAT SECONDS MILLISECONDS MINUTES HOURS STANDARD CURRENCY FEET MILES METERS KILOMETERS)

      value
    end

  end
end