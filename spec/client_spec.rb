require 'spec_helper'

describe Foauth do
  class TestMiddleware < Faraday::Middleware
    def call(env)
      env['foo'] = 'bar'
      @app.call(env)
    end
  end

  let(:client) { Foauth.new('bob@example.org', '123') }
  let(:response) { client.get('https://api.twitter.com/1/statuses/user_timeline.json') }
  let(:request_headers) { response.env[:request_headers] }

  before do
    client.adapter :test do |stub|
      stub.get('/api.twitter.com/1/statuses/user_timeline.json') { [200, {}, '{}'] }
    end
  end

  it "authenticates with email and password" do
    expect(request_headers['Authorization']).to eq 'Basic Ym9iQGV4YW1wbGUub3JnOjEyMw=='
  end

  describe "with a block" do
    let(:client) { Foauth.new('bob@example.org', '123') { |builder| builder.use TestMiddleware } }
    it "runs the given block" do
      expect(response.env['foo']).to eq 'bar'
    end
  end
end
