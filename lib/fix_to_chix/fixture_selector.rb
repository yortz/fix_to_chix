module FixToChix

  class FixtureSelector
    
    attr_reader :test_fixtures_dir, :spec_fixtures_dir

    def initialize(options={})
      @test_fixtures_dir = options[:test_fixtures_dir] || TEST_FIXTURES
      @spec_fixtures_dir = options[:spec_fixtures_dir] || SPEC_FIXTURES
    end

    def spec_fixtures(options={})
      all_fixtures = fetch_fixtures.select {|f| f =~ /spec/ }
      filter(all_fixtures, options)
    end

    def test_fixtures(options={})
      all_fixtures = fetch_fixtures.select {|f| f =~ /test/ }
      filter(all_fixtures, options)
    end

    private
    def fetch_fixtures
      project_fixtures = []
      project_fixtures.concat(fetch_dir_files(self.test_fixtures_dir))
      project_fixtures.concat(fetch_dir_files(self.spec_fixtures_dir))
      project_fixtures
    end
    
    def fetch_dir_files(dir)
      Dir[dir] unless Dir[dir].empty?
    end

    def filter(all_fixtures, options)
      return all_fixtures.select {|f| f =~ options[:matching] } unless options[:matching].nil?
      all_fixtures
    end

  end

end