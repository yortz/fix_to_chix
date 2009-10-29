require File.dirname(__FILE__) + '/spec_helper.rb'

describe FixToChix::Controller do 
  
  it "should parse it all" do
    selector = mock('FixtureSelector', :spec_fixtures => [], :test_fixtures => [])
    FixToChix::FixtureSelector.should_receive(:new).and_return(selector)
    FixToChix::Controller.parse_it_all!
  end

end