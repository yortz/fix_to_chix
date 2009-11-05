require File.dirname(__FILE__) + '/spec_helper.rb'

describe FixToChix do
    
  it "prints usage if no arguments passed" do
    lambda{ FixToChix.execute }.should raise_error(ArgumentError)
  end

  it "accepts matching arguments" do
    FixToChix::Controller.should_receive(:parse_it_all!).with(:matching => "chewbacca")
    FixToChix.execute(:matching => "chewbacca")
  end

end
