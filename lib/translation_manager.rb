require './lib/translation_file'
require './lib/translator'

class TranslationManager
  def initialize(input_file, options={})
    @input_file = input_file
    input_text = read_file(@input_file)
    @translation_file = TranslationFile.new(input_text)
    @translator = Translator.new
  end

  def simple_translation(to_lang, translation_service)
    translation = @translator.translate(translation_service, @translation_file.input_text, to_lang)
    @translation_file.save_translation(translation, to_lang, translation_service)
    save_to_file(translation, "#{to_lang}_#{translation_service}")
  end

  # TODO: from_lang won't be needed if a proper response is constructed from translator: (from, to, text)
  def reversed_translation(from_lang, inter_lang, translation_service)
    translation = @translator.translate(translation_service, @translation_file.input_text, inter_lang, from_lang)
    doubled_translation = @translator.translate(translation_service, translation, from_lang, inter_lang)
    save_to_file(doubled_translation, "reversed_#{inter_lang}_#{translation_service}")
  end

  def translate_to_all_languages_with(translation_service)
    translations = @translator.translate_to_all_supported_languages(translation_service, @translation_file.input_text)
    translations.each do |lang, translation|
      @translation_file.save_translation(translation, lang, translation_service)
      save_to_file(translation, "#{lang}_#{translation_service}")
    end
  end

  def reverse_translate_to_all_languages_with(translation_service, from_lang)
    translations = @translator.translate_to_all_supported_languages(translation_service, @translation_file.input_text, from_lang)
    translations.each do |lang, translation|
      @translation_file.save_translation(translation, lang, translation_service)
      doubled_translation = @translator.translate(translation_service, translation, from_lang, lang)
      save_to_file(doubled_translation, "reversed_#{lang}_#{translation_service}")
    end
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
    File.open("#{file_path}/#{file_name} (#{postfix}).txt", 'w') {|f| f.write(text) }
  end

end
