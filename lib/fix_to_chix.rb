$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'activesupport'
require 'fix_to_chix/controller'

module FixToChix

  VERSION = '0.0.1'

  APP_ROOT = "." # have to call fixtochix from the app base

  TEST_FIXTURES = "#{APP_ROOT}/test/fixtures/*"
  SPEC_FIXTURES = "#{APP_ROOT}/spec/fixtures/*"

  SPEC_TARGET = "#{APP_ROOT}/spec"
  TEST_TARGET = "#{APP_ROOT}/test"

  SPEC_TARGET_FILE = "#{SPEC_TARGET}/factories.rb"
  TEST_TARGET_FILE = "#{TEST_TARGET}/factories.rb"

  def self.execute
    FixToChix::Controller.parse_it_all!
  end

end