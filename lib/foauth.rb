require 'faraday'

require 'foauth/version'
require 'foauth/rewrite_middleware'

module Foauth
  def self.new(email, password, &block)
    Faraday.new do |builder|
      builder.request :basic_auth, email, password
      builder.use RewriteMiddleware
      builder.adapter Faraday.default_adapter
      block.call(builder) if block_given?
    end
  end
end
