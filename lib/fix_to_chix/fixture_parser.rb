module FixToChix

  class FixtureParser

    attr_reader :output_buffer, :factory_names

    def initialize(fixture_file)
      raise ArgumentError if fixture_file.nil?
      raise StandardError unless File.exists?(fixture_file)
      @fixture_file = fixture_file
    end

    def model_name
      @fixture_file.match(/(\w+)\.yml/)
      $1.singularize
    end

    def parse_fixture
      @current_fixture = YAML.load_file(@fixture_file)
      @factory_names = @current_fixture.map{ |key, value| key }
      @output_buffer = define_factories
    end

    def attributes_for(factory_name)
      @current_fixture[factory_name].map {|key, value| key if key != "id" }
    end

    def define_factories
      factory_definition = ""
      @factory_names.each do |name|
        factory_definition << "Factory.define :#{name}, :class_name => #{model_name.capitalize} do |#{model_name[0].chr}| \n"
        factory_definition << define_attributes_for(name)
        factory_definition << "\nend"
      end
      factory_definition
    end

    def define_attributes_for(name)
      attributes = attributes_for(name)
      attributes.map {|attr| write_factory_attribute(name, attr) }.join if attributes
    end

    def write_factory_attribute(name, attribute)
      attr_value = @current_fixture[name][attribute]
      attr_value = attr_value.to_i == 0 ? "'#{attr_value}'" : "#{attr_value}"
      "#{model_name[0].chr}.#{attribute} #{attr_value}"
    end
  end
end