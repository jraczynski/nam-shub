require 'tr4n5l4te'

class GoogleAPI
  attr_reader :character_limit, :supported_languages

  def initialize(config)
    @character_limit = config['character_limit']
    @supported_languages = config['languages'].map(&:to_sym)
    @translator = Tr4n5l4te::Translator.new
  end

  def translate(text, to_lang, from_lang=:en)
    begin
      translations = []
      text.each_line do |line|
        t = @translator.translate(line, from_lang, to_lang) #TODO: restore en
        translations << t
      end
      translations.join('\n')
    rescue
      raise "Something went wrong!"
    end
  end
end
