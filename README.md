# Foauth

Use [foauth.org](https://foauth.org) from Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'foauth'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install foauth

## Usage

Create a new client passing in your foauth email and password.

```ruby
client = Foauth.new('bob@example.org', 'secret')
```

When you make a request the url will automatically be converted to a
foauth url using the hostname and the path.

```ruby
response = client.get('https://api.twitter.com/1/statuses/user_timeline.json')
# An authenticated request is made to https://foauth.org/api.twitter.com/1/statuses/user_timeline.json
puts response.success?
puts response.body
puts response.status
```

The `client` returned is an instance of `Faraday::Connection`, you can treat
it accordingly.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Inspired by
[requests-foauth](https://github.com/kennethreitz/requests-foauth) by
@kennethreitz.

Copyright (c) Chris Mytton
