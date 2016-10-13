require 'minitest/autorun'
require './test/test_helper'
require './lib/translation_file'

describe TranslationFile do
  before do
    @input_file = 'test/samples/input_file.txt'
    @translation_file = TranslationFile.new(@input_file, 1000)
  end

  describe '#read_file' do
    it 'splits text properly according to character limit' do
      @translation_file.read_file

      assert @translation_file.file_parts.all? { |part| part.length <= 1000 }
      @translation_file.file_parts[1][-1].must_equal '.'
      input_file_length = File.read(@input_file).length
      @translation_file.file_parts.inject(0) { |sum , part| sum + part.length }.must_equal input_file_length
    end
  end
end
