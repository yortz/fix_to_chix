require File.dirname(__FILE__) + '/spec_helper.rb'

describe FixToChix::FixtureSelector, "selecting fixtures" do
  
  before do
    @ftc_fixture_selector = FixToChix::FixtureSelector.new
    @ftc_fixture_selector.stub!(:fetch_fixtures).and_return(["spec/fixtures/users.yml","spec/fixtures/user_items.yml", "test/posts.yml"])
  end

  it "selects all fixtures by default" do
    @ftc_fixture_selector.spec_fixtures.should == ["spec/fixtures/users.yml","spec/fixtures/user_items.yml"]
    @ftc_fixture_selector.test_fixtures.should == ["test/posts.yml"]
  end

  it "selects matching with regexp" do
    @ftc_fixture_selector.spec_fixtures(:matching => /item/).should == ["spec/fixtures/user_items.yml"]
    @ftc_fixture_selector.test_fixtures(:matching => /user/).should == []
  end
  
end
