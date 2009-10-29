module FixToChix
  
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
  
end