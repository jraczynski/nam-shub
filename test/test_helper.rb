require "minitest/reporters"
Minitest::Reporters.use!

require 'webmock/minitest'

require 'vcr'
VCR.configure do |config|
  config.default_cassette_options = { record: :new_episodes, match_requests_on: [:body, :method, :uri] }
  config.cassette_library_dir = 'test/vcr_cassettes'
  config.hook_into :webmock
end
