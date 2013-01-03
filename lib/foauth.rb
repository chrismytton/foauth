require 'foauth/version'
require 'foauth/rewrite_middleware'
require 'foauth/client'

module Foauth
  def self.new(*args, &block)
    Foauth::Client.new(*args, &block)
  end
end
