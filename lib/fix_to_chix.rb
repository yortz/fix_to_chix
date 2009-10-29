$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module FixToChix
  VERSION = '0.0.1'

  unless defined?(RAILS_ROOT)
    RAILS_ROOT = '.'
  end

  TEST_FIXTURES = "#{RAILS_ROOT}/test/fixtures"
  SPEC_FIXTURES = "#{RAILS_ROOT}/spec/fixtures"
  
  SPEC_TARGET = "#{RAILS_ROOT}/spec/"
  TEST_TARGET = "#{RAILS_ROOT}/test/"

  class FixtureSelector
    
    def initialize
    end

    def fixtures(options={})
      all_fixtures = fetch_fixtures
      unless options[:matching].nil?
        all_fixtures = all_fixtures.select {|f| f =~ options[:matching] }
      end
      all_fixtures
    end

    private
    def fetch_fixtures
      project_fixtures = []
      project_fixtures.concat(Dir[TEST_FIXTURES]) unless Dir[TEST_FIXTURES].empty?
      project_fixtures.concat(Dir[SPEC_FIXTURES]) unless Dir[SPEC_FIXTURES].empty?
      project_fixtures
    end
  end
  
  class FactoryWriter
    attr_reader :target_folder
    
    def initialize(options={})
      @target_folder = TEST_TARGET
      @target_folder = SPEC_FIXTURES if !options[:target].nil? && options[:target] == :spec
    end
  end
end