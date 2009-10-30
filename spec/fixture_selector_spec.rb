require File.dirname(__FILE__) + '/spec_helper.rb'

describe FixToChix::FixtureSelector do

  describe "selecting fixtures" do
    
    before do
      @selector = FixToChix::FixtureSelector.new
      @selector.stub!(:test_fixtures_dir).and_return("test")
      @selector.stub!(:spec_fixtures_dir).and_return("spec")
      @selector.stub!(:fetch_dir_files).with("test").and_return(["test/posts.yml"])
      @selector.stub!(:fetch_dir_files).with("spec").and_return(["spec/fixtures/users.yml","spec/fixtures/user_items.yml"])
    end

    it "selects all fixtures by default" do
      @selector.spec_fixtures.should == ["spec/fixtures/users.yml","spec/fixtures/user_items.yml"]
      @selector.test_fixtures.should == ["test/posts.yml"]
    end

    it "selects matching with regexp" do
      @selector.spec_fixtures(:matching => /item/).should == ["spec/fixtures/user_items.yml"]
      @selector.test_fixtures(:matching => /user/).should == []
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
