require File.dirname(__FILE__) + '/spec_helper.rb'

describe FixToChix::Controller do

  it "parses spec fixtures" do
    selector = mock('FixtureSelector', :spec_fixtures => ["spec_fix"], :test_fixtures => [])
    FixToChix::FixtureSelector.stub!(:new).and_return(selector)
    FixToChix::FixtureParser.should_receive(:new).with("spec_fix").and_return(mock('selector', :parse_fixture => "", :output_buffer => "buff"))
    FixToChix::FactoryWriter.should_receive(:write).with("buff", FixToChix::SPEC_TARGET_FILE)
    FixToChix::Controller.parse_it_all!
  end

  it "parses test fixtures" do
    selector = mock('FixtureSelector', :spec_fixtures => [], :test_fixtures => ["test_fix"])
    FixToChix::FixtureSelector.stub!(:new).and_return(selector)
    FixToChix::FixtureParser.should_receive(:new).with("test_fix").and_return(mock('selector', :parse_fixture => "", :output_buffer => "buff"))
    FixToChix::FactoryWriter.should_receive(:write).with("buff", FixToChix::TEST_TARGET_FILE)
    FixToChix::Controller.parse_it_all!
  end

  it "accepts matching file options for selector" do
    FixToChix::FixtureSelector.should_receive(:new).with(:matching => /anakin/).and_return(mock('Selector', :spec_fixtures => [], :test_fixtures => []))
    FixToChix::Controller.parse_it_all!(:matching => "anakin")
  end

  it "receives empty hash if no arg" do
    FixToChix::FixtureSelector.should_receive(:new).with({}).and_return(mock('Selector', :spec_fixtures => [], :test_fixtures => []))
    FixToChix::Controller.parse_it_all!
  end

end