# Google Search Console API Ruby Gem [WIP]
This is a simple wrapper to interact with the Google Search Console API with Ruby.
It's based on the [Official API reference](https://developers.google.com/webmaster-tools/v1/api_reference_index).

## Usage
Add this gem to your Gemfile:
```rb
gem 'search_console_api'
```

You will need a way to get a user's valid (and fresh) token (I personally use the `gem omnioauth`), and then:

### Initialize a Client
```rb
client = SearchConsoleApi::Client.new(token)
# List all the sites
sites = client.sites
```

### Search Analytics API
```rb
# prepare the most basic query:
query = SearchConsoleApi::Query.new(
  start_date: Date.parse("2024/01/01"),
  end_date: Date.parse("2024/01/31")
)

# or prepare a complex query
query = SearchConsoleApi::Query.new(
  start_date: Date.parse("2024/01/01"),
  end_date: Date.parse("2024/01/31"),
  dimensions: %w[country device page query searchAppearance], # These are all the supported values.
  type: "web", # Supported values: discover, googleNews, news, image, video, web. Default value is "web".
  dimension_filter_groups: [],
  aggregation_type: "auto", # Supported values: auto, byNewsShowcasePanel, byPage, byProperty. Default value is "auto".
  row_limit: 1000, # Supported values: between 1 and 25000. Default value is 1000.
  start_row: 0,
  data_state: "all" # Supported values: all, final.
)

response = client.run_query(query)

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dailytics/search_console_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/dailytics/search_console_api/blob/main/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PlausibleApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dailytics/search_console_api/blob/main/CODE_OF_CONDUCT.md).