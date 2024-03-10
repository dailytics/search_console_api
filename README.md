# Google Search Console API Ruby Gem [WIP]
This is a simple wrapper to interact with the Google Search Console API with Ruby.
It's based on the [Official API reference](https://developers.google.com/webmaster-tools/v1/api_reference_index).

The first version is intended for read access only, not adding sites, sitemaps, etc.

## Usage
Add this gem to your Gemfile:
```rb
gem 'search_console_api'
```

You will need a way to get a user's valid (and fresh) token (I personally use the `gem omnioauth`).
Make sure you added the following scope:

```
https://www.googleapis.com/auth/webmasters.readonly
```

### Initialize a Client
```rb
client = SearchConsoleApi::Client.new(token)
```

### List all the sites
```rb
# List all the sites
sites = client.sites
=>
[#<SearchConsoleApi::Objects::Site:0x0000000109194e98 @permission_level="siteOwner", @site_url="https://dailytics.com/">,
 #<SearchConsoleApi::Objects::Site:0x0000000109194e48 @permission_level="siteUnverifiedUser", @site_url="http://www.anothersite.com/">,
 #<SearchConsoleApi::Objects::Site:0x0000000109194e20 @permission_level="siteOwner", @site_url="sc-domain:anothersite2.com">,
 #<SearchConsoleApi::Objects::Site:0x0000000109194df8 @permission_level="siteOwner", @site_url="sc-domain:anothersite3.com">]
 my_site = sites[0]
```
The response will be an array of `SearchConsoleApi::Objects::Site` objects, you will need to set one of them as a variable (let's call it `my_site`)
for the next step.

### Search Analytics API
The `query` method will receive the `site` parameter plus all the allowed parameters according to the [Google documentation](https://developers.google.com/webmaster-tools/v1/api_reference_index).
The 2 required parameters are `start_date` and `end_date`.
You will probably want to add the `dimensions` parameters (like in the second example).
```rb
# a basic query:
response = client.query(site: my_site, start_date: "2024/03/01", end_date: "2024/04/01")
=> [#<SearchConsoleApi::Objects::QueryResponseRow:0x000000010929d510 @clicks=69, @ctr=0.04542462146148782, @impressions=1519, @keys=nil, @position=15.596445029624753>]

# a more compled query:
response = client.query(site: my_site, start_date: "2024/03/01", end_date: "2024/04/01", dimensions: ["query"], row_limit: 3)
=>
[#<SearchConsoleApi::Objects::QueryResponseRow:0x0000000109324c18
  @clicks=7,
  @ctr=0.21212121212121213,
  @impressions=33,
  @keys=["crew release form"],
  @position=2.0606060606060606,
  @query="crew release form">,
 #<SearchConsoleApi::Objects::QueryResponseRow:0x0000000109324b78
  @clicks=3,
  @ctr=0.16666666666666666,
  @impressions=18,
  @keys=["filming notice template"],
  @position=1.5,
  @query="filming notice template">,
 #<SearchConsoleApi::Objects::QueryResponseRow:0x0000000109324ad8
  @clicks=3,
  @ctr=0.10714285714285714,
  @impressions=28,
  @keys=["location agreement template"],
  @position=5.392857142857143,
  @query="location agreement template">]
```

The response will be an array of `SearchConsoleApi::Objects::QueryResponseRow` objects, representing each row of the original response.
In case you added the `dimensions` parameter, each `QueryResponseRow` object will have the same dimensions as attributes for a
simpler manipulation.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dailytics/search_console_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/dailytics/search_console_api/blob/main/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PlausibleApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dailytics/search_console_api/blob/main/CODE_OF_CONDUCT.md).