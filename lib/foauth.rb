require 'faraday'

require 'foauth/version'
require 'foauth/rewrite_middleware'

module Foauth
  def self.new(email, password)
    Faraday.new do |builder|
      builder.request :basic_auth, email, password
      builder.use RewriteMiddleware
      builder.adapter Faraday.default_adapter
    end
  end
end
