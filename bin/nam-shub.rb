require './lib/translation_manager'

# TODO: named parameters
# TODO: path param, eg. en_pl_jp_en
input_file = ARGV[0]
to_lang = ARGV[1]
translation_service = ARGV[2]

manager = TranslationManager.new(input_file)
# manager.simple_translation(to_lang.to_sym, translation_service.to_sym)
# manager.reversed_translation(:en, to_lang.to_sym, translation_service.to_sym)
# manager.translate_to_all_languages_with translation_service.to_sym
manager.reverse_translate_to_all_languages_with translation_service.to_sym, :en
