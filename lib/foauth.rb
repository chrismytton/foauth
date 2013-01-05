require 'faraday'
require 'foauth/version'

module Foauth
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
      env[:url] = uri_for(env[:url])
      @app.call(env)
    end

    private

    def uri_for(url)
      uri = URI.parse("https://foauth.org/#{url.host}#{url.path}")
      uri.query = url.query
      uri
    end
  end
end
