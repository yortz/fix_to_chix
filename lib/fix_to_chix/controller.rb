require 'fix_to_chix/fixture_selector'
require 'fix_to_chix/factory_writer'
require 'fix_to_chix/fixture_parser'

module FixToChix
  class Controller
    def self.parse_it_all!
      
      selector = FixtureSelector.new
      
      selector.spec_fixtures.each do |fixture_file_name|
        parser = FixtureParser.new(fixture_file_name)
        parser.parse_fixture
        FactoryWriter.write(parser.output_buffer, SPEC_TARGET_FILE)
      end
      
      selector.test_fixtures.each do |fixture_file_name|
        parser = FixtureParser.new(fixture_file_name)
        parser.parse_fixture
        FactoryWriter.write(parser.output_buffer, TEST_TARGET_FILE)
      end
      
    end
  end
end