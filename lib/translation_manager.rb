require './lib/translation_file'
require './lib/translator'

class TranslationManager
  def initialize(input_file, options={})
    @input_file = input_file
    input_text = read_file(@input_file)
    @translation_file = TranslationFile.new(input_text)
    @translator = Translator.new
  end

  # TODO: translate to all supported languages through all supported apis?
  def simple_translation(to_lang, translation_service)
    translated_text = @translator.translate(translation_service, @translation_file.input_text, to_lang)
    @translation_file.save_translation(translated_text, to_lang, translation_service)
    save_to_file(translated_text, "#{to_lang}_#{translation_service}")
  end

  private

  def read_file(input_file)
    raise 'File not found!' unless File.exists? input_file
    input_text = File.read(input_file)
    input_text.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
    input_text.encode!('UTF-8', 'UTF-16')
    input_text
  end

  def save_to_file(text, postfix)
    file_name = File.basename(@input_file, '.*')
    file_path = File.dirname(@input_file)
    File.open("#{file_path}/#{file_name}_#{postfix}.txt", 'w') {|f| f.write(text) }
  end

end