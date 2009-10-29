require File.dirname(__FILE__) + '/spec_helper.rb'

describe FixToChix do

  describe FixToChix::FixtureSelector, "selecting fixtures" do

    it "selects all fixtures by default" do
      ftc_fixture_selector = FixToChix::FixtureSelector.new
      ftc_fixture_selector.should_receive(:fetch_fixtures).and_return(["users.yml","user_item.yml", "posts.yml"])
      ftc_fixture_selector.fixtures.should == ["users.yml","user_item.yml", "posts.yml"]
    end

    it "selects matching with regexp" do
      ftc_fixture_selector = FixToChix::FixtureSelector.new
      ftc_fixture_selector.should_receive(:fetch_fixtures).and_return(["users.yml","user_item.yml", "posts.yml"])
      ftc_fixture_selector.fixtures(:matching => /user/).should == ["users.yml","user_item.yml"]
    end

  end

  describe FixToChix::FactoryWriter, "writing factories" do

    it "targets test factories by default" do
      ftc_fixture_selector = FixToChix::FactoryWriter.new
      ftc_fixture_selector.target_folder.should match(/test/)
    end

    it "targets spec factories if argument" do
      ftc_fixture_selector = FixToChix::FactoryWriter.new(:target => :spec)
      ftc_fixture_selector.target_folder.should match(/spec/)
    end
  end

end
