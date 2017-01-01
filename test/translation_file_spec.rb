require 'minitest/autorun'
require './test/test_helper'
require './lib/translation_file'

describe TranslationFile do
  before do
    @input_text = File.read('test/samples/input_file.txt')
    @translation_file = TranslationFile.new(@input_text)
  end

  describe '#save_translation' do
    it 'saves the translation properly' do
      @translation_file.save_translation('Translated text', :en, :yandex)
      proper_translations_data = {
          en: {
              yandex: 'Translated text'
          }
      }
      @translation_file.translations.must_equal proper_translations_data
    end
  end
end
