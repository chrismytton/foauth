require 'spec_helper'

describe Foauth do
  let(:client) { Foauth.new('bob@example.org', '123') }
  let(:response) { client.get('https://api.twitter.com/1/statuses/user_timeline.json') }
  let(:auth) { response.env[:request_headers]['Authorization'] }

  before do
    client.adapter :test do |stub|
      stub.get('/api.twitter.com/1/statuses/user_timeline.json') { [200, {}, '{}'] }
    end
  end

  it "authenticates with email and password" do
    auth.should == 'Basic Ym9iQGV4YW1wbGUub3JnOjEyMw=='
  end
end
