module FixToChix

  class FixtureSelector

    def initialize
    end

    def spec_fixtures(options={})
      all_fixtures = fetch_fixtures(options).select {|f| f =~ /spec/ }
      filter(all_fixtures, options)
    end

    def test_fixtures(options={})
      all_fixtures = fetch_fixtures(options).select {|f| f =~ /test/ }
      filter(all_fixtures, options)
    end

    private
    def fetch_fixtures(options)
      project_fixtures = []
      project_fixtures.concat(Dir[TEST_FIXTURES]) unless Dir[TEST_FIXTURES].empty?
      project_fixtures.concat(Dir[SPEC_FIXTURES]) unless Dir[SPEC_FIXTURES].empty?
      project_fixtures
    end

    def filter(all_fixtures, options)
      return all_fixtures.select {|f| f =~ options[:matching] } unless options[:matching].nil?
      all_fixtures
    end

  end

end