require './lib/translation_manager'

# TODO: named parameters
input_file = ARGV[0]
to_lang = ARGV[1]
translation_service = ARGV[2]

manager = TranslationManager.new(input_file)
manager.simple_translation(to_lang.to_sym, translation_service.to_sym)