module SearchConsoleApi
  module Objects
    class QueryResponseRow
      attr_accessor :keys, :clicks, :impressions, :ctr, :position,
        :date, :device, :page, :query, :country, :search_appearance

      def initialize(attributes = {}, dimensions = [])
        @keys = attributes["keys"]
        @clicks = attributes["clicks"]
        @impressions = attributes["impressions"]
        @ctr = attributes["ctr"]
        @position = attributes["position"]

        dimensions.each_with_index do |dimension, index|
          instance_variable_set("@#{dimension}", @keys[index])
        end
      end
    end
  end
end