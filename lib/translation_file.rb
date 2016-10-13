class TranslationFile
  attr_accessor :file_parts

  def initialize(input_file, character_limit=10_000)
    raise 'File not found!' unless File.exists? input_file
    @input_file = input_file
    @character_limit = character_limit
    @file_parts = []
  end

  def read_file
    buffer = ''
    File.foreach(@input_file) do |line|
      if buffer.length + line.length > @character_limit
        line_limit = @character_limit - buffer.length
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
  end
end