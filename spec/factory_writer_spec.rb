require File.dirname(__FILE__) + '/spec_helper.rb'

describe FixToChix::FactoryWriter, "writing factories" do

  it "should write the output buffer" do
    File.should_receive(:open).with("factories_file", 'a').and_yield(mock("file handler", :puts => ""))
    buffer = mock("output buffer", :each => "bla")
    FixToChix::FactoryWriter.write(buffer, "factories_file")
  end

end
