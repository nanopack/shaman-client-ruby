$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'shaman'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:any, /127.0.0.1/).to_rack(FakeShaman)
  end
end
