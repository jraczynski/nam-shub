class TranslationFile
  attr_reader :input_text, :translations

  def initialize(input_text, options={})
    @input_text = input_text
    @translations = {}
    # TODO: save from_lang somehow, it will be needed for reverse translation
    # TODO: remove reader for translations, and prepare methods for getting translations for specific lang and service?
    # in many combinations, eg. get all translations for single lang, or all translations for single service etc.
  end

  def save_translation(translated_text, to_lang, translation_service)
    @translations[to_lang] ||= {}
    @translations[to_lang][translation_service] = translated_text
  end
end