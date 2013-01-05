require 'faraday'
require 'foauth/version'

module Foauth
  # Creates a new `Faraday` instance using the given `email` and `password`.
  #
  # @param [String] email Your foauth.org email address.
  # @param [String] password Your foauth.org password.
  # @return [Faraday::Connection] Configured to proxy requests to foauth.org.
  def self.new(email, password)
    Faraday.new do |builder|
      builder.request :basic_auth, email, password
      builder.use RewriteMiddleware
      builder.adapter Faraday.default_adapter
      yield builder if block_given?
    end
  end

  class RewriteMiddleware < Faraday::Middleware
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
