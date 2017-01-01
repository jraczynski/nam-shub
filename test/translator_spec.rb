require 'minitest/autorun'
require './test/test_helper'
require './lib/translator'
require './lib/api/yandex_api'

describe Translator do
  before do
    @translator = Translator.new
    @input_text = File.read('test/samples/input_file.txt')
  end

  describe '#split_text' do
    it 'splits text properly according to character limit' do
      file_parts = @translator.send(:split_text,@input_text, 1000)

      assert file_parts.all? { |part| part.length <= 1000 }
      file_parts[1][-1].must_equal '.'
      file_parts.inject(0) { |sum , part| sum + part.length }.must_equal @input_text.length
    end
  end

  describe '#translate' do
    it 'translates with a chosen API' do
      # TODO: stub YandexAPI instead of using VCR?
      VCR.use_cassette('yandex_api') do
        @translator.translate(:yandex, 'cow', :pl).must_equal 'krowa'
      end
    end
  end
end
