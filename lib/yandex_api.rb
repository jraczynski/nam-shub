require 'httparty'

class YandexAPI
  include HTTParty
  base_uri 'https://translate.yandex.net/api/v1.5/tr.json'

  def initialize(api_key)
    @api_key = api_key
  end

  def translate(text, to_lang, from_lang=nil)
    options = {
        body: {
          key: @api_key,
          lang: "#{from_lang}-#{to_lang}",
          text: text
        }
    }
    response = self.class.post('/translate', options)
    response['text'][0]
  end
end