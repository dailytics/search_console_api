module SearchConsoleApi
  module Resources
    module Sites
      class List
        def initialize(access_token:)
          @access_token = access_token
        end

        def call
          return [] unless response["siteEntry"].is_a?(Array)

          response["siteEntry"].each_with_object([]) do |attrs, sites|
            sites << Objects::Site.new(attrs)
          end
        end

        private

        def response
          @response ||= Request.get(access_token: @access_token, path: "/sites")
        end
      end
    end
  end
end