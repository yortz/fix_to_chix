require File.dirname(__FILE__) + '/spec_helper.rb'

describe FixToChix do
  
  it "should parse it all" do
    FixToChix::Controller.should_receive(:parse_it_all!)
    FixToChix.execute
  end
  
end