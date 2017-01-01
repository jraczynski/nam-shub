require 'httparty'

class YandexAPI
  include HTTParty
  base_uri 'https://translate.yandex.net/api/v1.5/tr.json' #TODO: base URI from config?

  attr_reader :character_limit

  def initialize(config)
    @api_key = config['api_key']
    @character_limit = config['character_limit']
    #TODO: other parameters
  end

  def translate(text, to_lang, from_lang=nil)
    lang = from_lang ? "#{from_lang}-#{to_lang}" : to_lang
    options = {
        body: {
          key: @api_key,
          lang: lang,
          text: text
        }
    }
    response = self.class.post('/translate', options)
    response['text'][0]
  end
end