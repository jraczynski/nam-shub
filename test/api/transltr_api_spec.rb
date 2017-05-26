require 'minitest/autorun'
require '././test/test_helper'
require '././lib/api/transltr_api'

describe TransltrAPI do
  before do
    config = YAML.load_file('./config/transltr.yml')
    @transltr_api = TransltrAPI.new(config)
  end

  describe '#translate' do
    it 'should translate a simple text from polish to english' do
      VCR.use_cassette('transltr_api') do
        @transltr_api.translate('pies', 'en', 'pl').must_equal 'Dog'
      end
    end
  end
end
