require 'httparty'

class TransltrAPI
  include HTTParty
  base_uri 'http://transltr.org/api'

  attr_reader :character_limit, :supported_languages

  def initialize(config)
    @api_key = config['api_key']
    @character_limit = config['character_limit']
    @supported_languages = config['languages'].map(&:to_sym)
  end

  def translate(text, to_lang, from_lang=nil)
    options = {
        body: {
          text: text,
          to: to_lang,
          from: from_lang
        }
    }
    response = self.class.post('/translate', options)
    if response['translationText']
      response['translationText']
    else
      raise "Something went wrong!"
    end
  end
end
