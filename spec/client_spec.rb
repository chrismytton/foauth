require 'spec_helper'

describe Foauth do
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
end
