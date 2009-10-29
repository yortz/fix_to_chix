module FixToChix
  
  class FactoryWriter
    attr_reader :target_folder

    def initialize(options={})
      @target_folder = TEST_TARGET
      @target_folder = SPEC_FIXTURES if !options[:target].nil? && options[:target] == :spec
    end
  end

end