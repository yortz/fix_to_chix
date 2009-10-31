begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  require 'spec'
end
begin
  require 'spec/rake/spectask'
rescue LoadError
  puts <<-EOS
  To use rspec for testing you must install rspec gem:
  gem install rspec
  EOS
  exit(0)
end

require 'spec/rake/spectask'
require "rcov/rcovtask"

namespace :spec do
  desc "Code coverage."
  Spec::Rake::SpecTask.new(:coverage) do |rcov|
    rcov.rcov = true
    rcov.rcov_dir = "reports/coverage"
    rcov.spec_opts = ["--format", "html:reports/specs/index.html", "--diff"]
    rcov.fail_on_error = false
    rcov.verbose = true 
    rcov.rcov_opts = [" -x gem, -x spec"]
  end
end