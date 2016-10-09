class TranslationFile
  attr_accessor :file_parts

  def initialize(input_file, character_limit=10_000)
    @input_file = input_file
    @character_limit = character_limit
  end

  def read_file
    #TODO: read line by line, and check character limit
    #when at the limit, try to save a part, but cut at the end of a sentence
  end
end