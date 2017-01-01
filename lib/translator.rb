require './lib/api/yandex_api'

# TODO: scan config folder, add and load all services automatically?
SUPPORTED_SERVICES = [:yandex]

class Translator
  def initialize
    @services = {}
    SUPPORTED_SERVICES.each do |service_name|
      case service_name
        when :yandex
          config = YAML.load_file './config/yandex.yml'
          @services[:yandex] = YandexAPI.new(config)
        else
          # do nothing
      end
    end
  end

  def translate(service_name, text, to_lang, from_lang=nil)
    if @services[service_name]
      api = @services[service_name]
    else
      raise 'Unsupported translation service.'
    end
    if api.character_limit # or do it by default to have smaller requests? eg. 10_000
      text_parts = split_text(text, api.character_limit)
      translated_text_parts = text_parts.map do |part|
        api.translate(part, to_lang, from_lang)
      end
      translated_text_parts.join
    else
      api.translate(text, to_lang, from_lang)
    end
  end

  private

  def split_text(text, character_limit=10_000)
    # TODO: simple string splitting instead of each_line? like each_part
    buffer = ''
    file_parts = []
    text.each_line do |line|
      if buffer.length + line.length > character_limit
        line_limit = character_limit - buffer.length
        buffer << line[0...line_limit]
        last_dot_position = buffer.rindex(/[.?!]/)
        if last_dot_position
          file_parts << buffer[0..last_dot_position]
          buffer = buffer[last_dot_position+1..-1] + line[line_limit..-1]
        else
          file_parts << buffer
          buffer = line[line_limit..-1]
        end
      else
        buffer << line
      end
    end
    if buffer.length
      file_parts << buffer
    end
    file_parts
  end
end