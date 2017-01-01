require 'minitest/autorun'
require '././test/test_helper'
require '././lib/api/yandex_api'

describe YandexAPI do
  before do
    config = YAML.load_file('./config/yandex.yml')
    @yandex_api = YandexAPI.new(config)
  end

  describe '#translate' do
    it 'should translate a simple text from polish to english' do
      VCR.use_cassette('yandex_api') do
        @yandex_api.translate('krowa', 'en', 'pl').must_equal 'cow'
      end
    end
  end
end
