require 'faraday'
require 'foauth/version'

module Foauth
  Faraday.register_middleware :request, :foauth_proxy => lambda { Proxy }

  # Creates a new `Faraday` instance using the given `email` and `password`.
  #
  # @param [String] email Your foauth.org email address.
  # @param [String] password Your foauth.org password.
  # @yield [builder] Passes the `Faraday::Builder` instance to the block if given.
  # @return [Faraday::Connection] Configured to proxy requests to foauth.org.
  def self.new(email, password)
    Faraday.new do |builder|
      builder.request :foauth_proxy
      builder.request :basic_auth, email, password
      builder.adapter Faraday.default_adapter
      yield builder if block_given?
    end
  end

  class Proxy < Faraday::Middleware
    def call(env)
      env[:url] = foauth_proxy_url(env[:url])
      @app.call(env)
    end

    private

    def foauth_proxy_url(url)
      uri = URI.parse("https://foauth.org/#{url.host}#{url.path}")
      uri.query = url.query
      uri
    end
  end
end
