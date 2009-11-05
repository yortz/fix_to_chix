require 'fix_to_chix/fixture_selector'
require 'fix_to_chix/factory_writer'
require 'fix_to_chix/fixture_parser'

module FixToChix
  class Controller
    
    class << self
    
      def parse_it_all!(options)
        matching_options = parse_matching_options(options)
        selector = FixtureSelector.new(matching_options)
        %w[spec test].each do |type| 
          selector.send("#{type}_fixtures").each do |fixture_file_name|
            parser = FixtureParser.new(fixture_file_name)
            parser.parse_fixture
            FactoryWriter.write(parser.output_buffer, FixToChix.class_eval("#{type.upcase}_TARGET_FILE"))
          end
        end
      end
      
      def parse_matching_options(options)
        return {} unless options[:matching]
        { :matching => Regexp.new(options[:matching]) }
      end
    
    end
  
  end
end