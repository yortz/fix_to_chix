$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'fix_to_chix/fixture_selector'
require 'fix_to_chix/factory_writer'
require 'fix_to_chix/fixture_parser'

module FixToChix
  
  VERSION = '0.0.1'

  unless defined?(RAILS_ROOT)
    RAILS_ROOT = '.'
  end

  TEST_FIXTURES = "#{RAILS_ROOT}/test/fixtures"
  SPEC_FIXTURES = "#{RAILS_ROOT}/spec/fixtures"
  
  SPEC_TARGET = "#{RAILS_ROOT}/spec/"
  TEST_TARGET = "#{RAILS_ROOT}/test/"

end