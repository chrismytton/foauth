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

  describe "with environment varaibles" do
    let(:client) do
      ENV['FOAUTH_EMAIL'] = 'foo@example.org'
      ENV['FOAUTH_PASSWORD'] = 'secret'
      Foauth.new
    end

    after do
      ENV.delete('FOAUTH_EMAIL')
      ENV.delete('FOAUTH_PASSWORD')
    end

    it "authenticates with environment credentials" do
      expect(request_headers['Authorization']).to eq 'Basic Zm9vQGV4YW1wbGUub3JnOnNlY3JldA=='
    end
  end
end
