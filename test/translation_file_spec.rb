require 'minitest/autorun'
require './test/test_helper'
require './lib/translation_file'

describe TranslationFile do
  before do
    input_file = 'test/samples/input_file.txt'
    @translation_file = TranslationFile.new(input_file, 1000)
  end

  describe '#read_file' do
    it 'splits text properly according to character limit' do
      @translation_file.read_file
      @translation_file.file_parts.length.must_equal 5
      @translation_file.file_parts[0].length.must_equal 1000
    end
  end
end
