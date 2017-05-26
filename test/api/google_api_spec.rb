require 'minitest/autorun'
require '././test/test_helper'
require '././lib/api/google_api'

describe GoogleAPI do
  before do
    config = YAML.load_file('./config/google.yml')
    @google_api = GoogleAPI.new(config)
  end

  describe '#translate' do
    it 'should translate a simple text from polish to english' do
      VCR.use_cassette('google_api') do
        @google_api.translate('krowa', 'en', 'pl').must_equal 'cow'
      end
    end
  end
end
