require File.dirname(__FILE__) + '/spec_helper.rb'

describe FixToChix::Controller do
  
  describe "parses spec fixtures" do
    
    it "parses spec fixtures" do
      selector = mock('FixtureSelector', :spec_fixtures => ["spec_fix"], :test_fixtures => [])
      FixToChix::FixtureSelector.stub!(:new).and_return(selector)
      FixToChix::FixtureParser.should_receive(:new).with("spec_fix").and_return(mock('Parser', :parse_fixture => "", :output_buffer => "buff"))
      FixToChix::FactoryWriter.stub!(:write).with("buff", FixToChix::SPEC_TARGET_FILE)
      FixToChix::Controller.parse_it_all!({})
    end
    
    it "writes to buffer" do
      selector = mock('FixtureSelector', :spec_fixtures => ["spec_fix"], :test_fixtures => [])
      FixToChix::FixtureSelector.stub!(:new).and_return(selector)
      FixToChix::FixtureParser.stub!(:new).with("spec_fix").and_return(mock('Parser', :parse_fixture => "", :output_buffer => "buff"))
      FixToChix::FactoryWriter.should_receive(:write).with("buff", FixToChix::SPEC_TARGET_FILE)
      FixToChix::Controller.parse_it_all!({})
    end
    
  end
  
  describe "parses test fixtures" do
    
    it "parses test fixtures" do
      selector = mock('FixtureSelector', :spec_fixtures => [], :test_fixtures => ["test_fix"])
      FixToChix::FixtureSelector.stub!(:new).and_return(selector)
      FixToChix::FixtureParser.should_receive(:new).with("test_fix").and_return(mock('Parser', :parse_fixture => "", :output_buffer => "buff"))
      FixToChix::FactoryWriter.stub!(:write).with("buff", FixToChix::TEST_TARGET_FILE)
      FixToChix::Controller.parse_it_all!({})
    end
    
    it "writes to buffer" do
      selector = mock('FixtureSelector', :spec_fixtures => [], :test_fixtures => ["test_fix"])
      FixToChix::FixtureSelector.stub!(:new).and_return(selector)
      FixToChix::FixtureParser.stub!(:new).with("test_fix").and_return(mock('Parser', :parse_fixture => "", :output_buffer => "buff"))
      FixToChix::FactoryWriter.should_receive(:write).with("buff", FixToChix::TEST_TARGET_FILE)
      FixToChix::Controller.parse_it_all!({})
    end
    
  end

  it "accepts matching one file options for selector" do
    FixToChix::FixtureSelector.should_receive(:new).with(:matching => /anakin/).and_return(mock('Selector', :spec_fixtures => [], :test_fixtures => []))
    FixToChix::Controller.parse_it_all!(:matching => "anakin")
  end
  
  it "accepts matching many files options for selector" do
    FixToChix::FixtureSelector.should_receive(:new).with(:matching => /anakin|yoda/).and_return(mock('Selector', :spec_fixtures => [], :test_fixtures => []))
    FixToChix::Controller.parse_it_all!(:matching => "anakin|yoda")
  end

  it "receives empty hash if no arguments for matching" do
    FixToChix::FixtureSelector.should_receive(:new).with({}).and_return(mock('Selector', :spec_fixtures => [], :test_fixtures => []))
    FixToChix::Controller.parse_it_all!({:bla => "bla"})
  end
  
  it "parses hash from matching arguments if given one" do
    matching_options = FixToChix::Controller.parse_matching_options(:matching => "blablabla")
    matching_options.should == { :matching => /blablabla/ }
  end
  
  it "parses hash from matching arguments if given two" do
    matching_options = FixToChix::Controller.parse_matching_options(:matching => "blablabla|ble")
    matching_options.should == { :matching => /blablabla|ble/ }
  end
  
  it "parses empty hash from matching arguments if none given" do
    matching_options = FixToChix::Controller.parse_matching_options({})
    matching_options.should == {}
  end
  
end