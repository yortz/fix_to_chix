require File.dirname(__FILE__) + '/spec_helper.rb'

describe FixToChix::FixtureSelector do

  describe "selecting fixtures" do

    it "selects all spec fixtures by default" do
      @selector = FixToChix::FixtureSelector.new
      @selector.stub!(:fetch_fixtures).and_return(["spec/fixtures/users.yml","spec/fixtures/user_items.yml", "test/fixtures/posts.yml"])
      @selector.spec_fixtures.should == ["spec/fixtures/users.yml","spec/fixtures/user_items.yml"]
    end

    it "selects all test fixtures by default" do
      @selector = FixToChix::FixtureSelector.new
      @selector.stub!(:fetch_fixtures).and_return(["spec/fixtures/users.yml","spec/fixtures/user_items.yml", "test/fixtures/posts.yml"])
      @selector.test_fixtures.should == ["test/fixtures/posts.yml"]
    end

    it "selects matching spec fixtures with regexp" do
      @selector = FixToChix::FixtureSelector.new(:matching => /item/)
      @selector.stub!(:fetch_fixtures).and_return(["spec/fixtures/users.yml","spec/fixtures/user_items.yml", "test/fixtures/posts.yml"])
      @selector.spec_fixtures.should == ["spec/fixtures/user_items.yml"]
    end

    it "selected matching test fixtures with regexp" do
      @selector = FixToChix::FixtureSelector.new(:matching => /space/)
      @selector.stub!(:fetch_fixtures).and_return(["spec/fixtures/users.yml","spec/fixtures/user_items.yml", "test/fixtures/posts.yml", "test/fixtures/space_guns.yml"])
      @selector.test_fixtures.should == ["test/fixtures/space_guns.yml"]
    end

  end

  describe "fetching fixtures" do

    it "gets from default dirs" do
      @selector = FixToChix::FixtureSelector.new
      Dir.stub!(:[]).with(FixToChix::TEST_FIXTURES).and_return(["test/fixtures/space_guns.yml"])
      Dir.stub!(:[]).with(FixToChix::SPEC_FIXTURES).and_return(["spec/fixtures/user_items.yml"])
      @selector.send(:fetch_fixtures).to_set.should == Set.new(["spec/fixtures/user_items.yml","test/fixtures/space_guns.yml"]) 
    end

  end

  describe "overriding default values" do
    it "changes test fixture dir" do
      @selector = FixToChix::FixtureSelector.new(:test_fixtures_dir => "/some/other")
      @selector.test_fixtures_dir.should == "/some/other"
    end

    it "changes spec fixture dir" do
      @selector = FixToChix::FixtureSelector.new(:spec_fixtures_dir => "/some/other")
      @selector.spec_fixtures_dir.should == "/some/other"
    end
  end
end
