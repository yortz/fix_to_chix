require 'fix_to_chix/fixture_selector'
require 'fix_to_chix/factory_writer'
require 'fix_to_chix/fixture_parser'

module FixToChix
  class Controller
    def self.parse_it_all!(options={})
      matching_option = options[:matching] ? { :matching => Regexp.new(options[:matching]) } : {}
      selector = FixtureSelector.new(matching_option)
      %w[spec test].each do |type| 
        selector.send("#{type}_fixtures").each do |fixture_file_name|
          parser = FixtureParser.new(fixture_file_name)
          parser.parse_fixture
          FactoryWriter.write(parser.output_buffer, FixToChix.class_eval("#{type.upcase}_TARGET_FILE"))
        end
      end
    end
  end
end