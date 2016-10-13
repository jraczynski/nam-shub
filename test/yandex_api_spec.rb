require 'minitest/autorun'
require './test/test_helper'
require './lib/yandex_api'

describe YandexAPI do
  before do
    config = YAML.load_file('./config/yandex.yml')
    @yandex_api = YandexAPI.new(config['api_key'])
  end

  describe '#translate' do
    it 'should translate a simple text from polish to english' do
      @yandex_api.translate('krowa', 'en', 'pl').must_equal 'cow'
    end
  end
end
