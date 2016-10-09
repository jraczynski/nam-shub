require 'translation_file'
require 'translator'

class TranslationManager
  def initialize(config_file, input_file)
    config = YAML.load_file(config_file)
    @translation_file = TranslationFile.new(input_file, config['character_limit'])
    @translator = Translator.new(config['api_key'], config['api_url'])
  end

end