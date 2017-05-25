require 'optparse'
require './lib/translation_manager'

# TODO: path param, eg. en_pl_jp_en

options = { source_file: nil, operation: nil, to: nil, from: nil, translation_service: nil }

OptionParser.new do |opts|
	opts.banner = "Usage: nam-shub.rb [options]"

	opts.on('-s', '--source FILE', 'Location of the source file') do |source|
		options[:source_file] = source;
	end

	opts.on('-o', '--operation operation', 'Translation operation: [simple, reversed, mass, mass_reversed]') do |operation|
		options[:operation] = operation;
	end

	opts.on('-f', '--from-lang lang', 'Source file language') do |from_lang|
		options[:from_lang] = from_lang.to_sym;
	end

	opts.on('-t', '--to-lang lang', 'Language to translate to') do |to_lang|
		options[:to_lang] = to_lang.to_sym;
	end

	opts.on('-p', '--provider provider', 'Translation provider, eg. yandex') do |provider|
		options[:translation_service] = provider.to_sym;
	end

	opts.on('-h', '--help', 'Displays Help') do
		puts opts
		exit
	end
end.parse!

manager = TranslationManager.new(options[:source_file])

#TODO: many situations like almost no options at all (mass translation), no service (default or all) etc.

case options[:operation]
when 'simple'
	manager.simple_translation options[:to_lang], options[:translation_service]
when 'reversed'
	manager.reversed_translation options[:from_lang], options[:to_lang], options[:translation_service]
when 'mass'
	manager.translate_to_all_languages_with options[:translation_service]
when 'mass_reversed'
	manager.reverse_translate_to_all_languages_with options[:translation_service], options[:from_lang]
else
	manager.simple_translation options[:to_lang], options[:translation_service]
end
