require File.dirname(__FILE__) + '/spec_helper.rb'

describe FixToChix do

  it "parses it all" do
    FixToChix::Controller.should_receive(:parse_it_all!)
    FixToChix.execute
  end

  it "accepts arguments if given" do
    FixToChix::Controller.should_receive(:parse_it_all!).with(:matching => "chewbacca")
    FixToChix.execute(["-m", "chewbacca"])
  end

  it "accepts passes empty hash if no argument" do
    FixToChix::Controller.should_receive(:parse_it_all!).with({})
    FixToChix.execute()
  end

end
