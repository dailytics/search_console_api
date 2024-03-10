require "search_console_api/version"

module SearchConsoleApi
  autoload :Client, "search_console_api/client"
  autoload :Request, "search_console_api/request"

  module Objects
    autoload :Site, "search_console_api/objects/site"
    autoload :QueryResponseRow, "search_console_api/objects/query_response_row"
  end

  module Resources
    module Sites
      autoload :List, "search_console_api/resources/sites/list"
    end

    module SearchAnalytics
      autoload :Query, "search_console_api/resources/search_analytics/query"
    end
  end

  autoload :Error, "search_console_api/error"
end
