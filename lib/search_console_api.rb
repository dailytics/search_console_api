require 'search_console_api/version'

module SearchConsoleApi
  autoload :Client, "search_console_api/client"
  autoload :Request, "search_console_api/request"
  autoload :Query, "search_console_api/query"
  autoload :QueryResponse, "search_console_api/query_response"
  autoload :QueryResponseRow, "search_console_api/query_response_row"
  autoload :Site, "search_console_api/site"
  autoload :Error, "search_console_api/error"
end