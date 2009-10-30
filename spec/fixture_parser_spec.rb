require File.dirname(__FILE__) + '/spec_helper.rb'

describe FixToChix::FixtureParser do

  it "raises error if no fixture file passed as argument" do
    lambda { FixToChix::FixtureParser.new }.should raise_error
  end

  it "raises error if file not found" do
    lambda { FixToChix::FixtureParser.new("bla/bla/bla") }.should raise_error
  end

  describe "reading file" do

    it "lists model class name" do
      parser = FixToChix::FixtureParser.new(File.dirname(__FILE__) + "/fixtures/authors.yml")
      parser.model_name.should == "author"
      parser = FixToChix::FixtureParser.new(File.dirname(__FILE__) + "/fixtures/posts.yml")
      parser.model_name.should == "post"
    end
  end

  describe "parsing" do

    before do
      @parser = FixToChix::FixtureParser.new(File.dirname(__FILE__) + "/fixtures/authors.yml")
      @parser.parse_fixture
    end

    it "saves output in output_buffer" do
      @parser.output_buffer.should_not be_empty
    end

    it "has factory names" do
      @parser.factory_names.to_set.should == Set.new(["anakin", "yoda"])
    end

    it "has attributes for each factory name" do
      @parser.attributes_for("anakin").should include("name", "blog")
    end

    it "doest not include id attribute" do
      @parser.attributes_for("anakin").should_not include("id")
    end

    it "writes defines factories" do
      @parser.parse_fixture
      @parser.output_buffer.join.should match(/Factory.define :anakin, :class_name => Author/)

      parser = FixToChix::FixtureParser.new(File.dirname(__FILE__) + "/fixtures/posts.yml")
      parser.parse_fixture
      parser.output_buffer.join.should match(/Factory.define :hello_world, :class_name => Post do \|p\|/)
    end
    
    it "camelizes class_name" do
      parser = FixToChix::FixtureParser.new(File.dirname(__FILE__) + "/fixtures/line_items.yml")
      parser.parse_fixture
      parser.output_buffer.join.should match(/Factory.define :bla, :class_name => LineItem do \|l\|/)
    end

    it "write attributes " do
      @parser.parse_fixture
      @parser.output_buffer.join.should match(/a.blog/)

      parser = FixToChix::FixtureParser.new(File.dirname(__FILE__) + "/fixtures/posts.yml")
      parser.parse_fixture
      parser.output_buffer.join.should match(/p.title/)
    end

    it "writes attributes with respective values" do
      @parser.parse_fixture
      @parser.output_buffer.join.should match(/a.blog 'I write a blog'/)
      @parser.output_buffer.join.should match(/a.age 900/)
    end

  end

end