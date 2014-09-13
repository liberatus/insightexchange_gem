# InsightExchange Ruby Gem

This is a simple wrapper gem for the InsightExchange REST API.

## Installation

Add this line to your application's Gemfile:

    gem 'insightexchange'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install insightexchange

## Usage

Instantiate a new client, providing the API token either through an environment variable or as an argument.

```ruby
exchange = InsightExchange.new #reads from ENV['INSIGHT_EXCHANGE_TOKEN']
exchange.publish user.email, 'CookedDinner'
# This will publish the insight and do one of the following.
#  1. If it is a new type of insight, it will be submitted for approval
#      first before being sent to anyone else.
#  2. If we have already approved insights by that title, it will
#      auction the insight off to the highest bidder that you have
#      accepted.
#  
```

Also, identify users early on in your registration flow to ensure breadth of coverage on the market.

```ruby
exchange.identify user.email
```

Please see the InsightExchange documentation for further details.
http://insightexchange.co/for_developers/docs

## Contributing

1. Fork it ( https://github.com/insightexchange/insightexchange/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
