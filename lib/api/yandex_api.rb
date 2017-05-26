require 'httparty'

class YandexAPI
  include HTTParty
  base_uri 'https://translate.yandex.net/api/v1.5/tr.json'

  attr_reader :character_limit, :supported_languages

  def initialize(config)
    @api_key = config['api_key']
    @character_limit = config['character_limit']
    @supported_languages = config['languages'].map(&:to_sym)
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
    if response['text']
      # {
      #   from: from_lang || response['lang'][0..1].to_sym,
      #   to: to_lang,
      #   text: response['text'][0]
      # }
      response['text'].first
    else
      raise response['message']
    end
  end
end
