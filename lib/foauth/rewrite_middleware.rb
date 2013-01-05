require 'faraday'

module Foauth
  class RewriteMiddleware < Faraday::Middleware
    def call(env)
      url = env[:url]
      env[:url] = URI.parse("https://foauth.org/#{url.host}#{url.path}")
      env[:url].query = url.query
      @app.call(env)
    end
  end
end
