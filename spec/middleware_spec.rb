require 'spec_helper'

describe Foauth::RewriteMiddleware do
  let(:conn) do
    conn = Faraday.new do |builder|
      builder.use Foauth::RewriteMiddleware
      builder.adapter :test do |stub|
        stub.get('/api.twitter.com/1/statuses/user_timeline.json') {[ 200, {}, '{}' ]}
      end
    end
  end

  it "changes the url for an intercepted request" do
    res = conn.get('https://api.twitter.com/1/statuses/user_timeline.json')
    expect(res.env[:url].to_s).to eq 'https://foauth.org/api.twitter.com/1/statuses/user_timeline.json'
  end

  it "preserves the query parameters" do
    res = conn.get('https://api.twitter.com/1/statuses/user_timeline.json', foo: 'bar')
    expect(res.env[:url].query).to eq 'foo=bar'
  end
end
