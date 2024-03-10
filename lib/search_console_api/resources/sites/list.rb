module SearchConsoleApi
  module Resources
    module Sites
      class List
        def initialize(access_token:)
          @access_token = access_token
        end

        def call
          response["siteEntry"].each_with_object([]) do |attrs, sites|
            sites << Objects::Site.new(attrs)
          end
        end

        private

        def response
          Request.get(access_token: @access_token, path: "/sites")
        end
      end
    end
  end
end