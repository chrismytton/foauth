# Foauth

[foauth.org][foauth] Ruby client built on top of [faraday][].

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

Create a new client passing in your [foauth][] email and password.

```ruby
client = Foauth.new('bob@example.org', 'secret')
```

When you make a request to one of the supported [foauth services][] the url will automatically be converted to a
foauth url using the hostname and the path.

```ruby
response = client.get('https://api.twitter.com/1/statuses/user_timeline.json')
# An authenticated request is made to https://foauth.org/api.twitter.com/1/statuses/user_timeline.json

puts response.success?  # true
puts response.body      # [{"created_at":"Mon Dec 31 23:59:13 +0000 2012"...
puts response.status    # 200
```

The `client` returned is an instance of `Faraday::Connection` and the
`response` is an instance of `Faraday::Response`. See [faraday][] for
more information.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Version history

**0.2.0** (January 5, 2013)

* Allow client to accept a block to configure Faraday
  ([#2](https://github.com/hecticjeff/foauth/issues/2))

**0.1.0** (January 5, 2013)

* Make sure query string is passed through to foauth
  ([#1](https://github.com/hecticjeff/foauth/issues/1))

**0.0.1** (January 3, 2013)

* Initial release

## Credits

Thanks to [@gulopine](https://github.com/gulopine) for creating
[foauth.org][foauth].

Inspired by [requests-foauth][] by
[@kennethreitz](https://github.com/kennethreitz).

Copyright (c) Chris Mytton

[foauth]: https://foauth.org
[faraday]: https://github.com/lostisland/faraday
[requests-foauth]: https://github.com/kennethreitz/requests-foauth
[foauth services]: https://foauth.org/services/
