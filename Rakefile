%w[rubygems rake rake/clean fileutils hoe newgem rubigen].each { |f| require f }
require File.dirname(__FILE__) + '/lib/fix_to_chix'

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec('fix_to_chix') do |p|
  p.developer('Caike Souza', 'caikesouza@caikesouza.com')
  p.summary =  'convert existing yaml fixtures to factory_girl factories'
  p.changes              = p.paragraphs_of("History.txt", 0..1).join("\n\n")
  p.rubyforge_name       = p.name
  p.extra_dev_deps = [
    ['newgem', ">= #{::Newgem::VERSION}"], ['activesupport']
  ]
  
  p.clean_globs |= %w[**/.DS_Store tmp *.log]
  path = (p.rubyforge_name == p.name) ? p.rubyforge_name : "\#{p.rubyforge_name}/\#{p.name}"
  p.remote_rdoc_dir = File.join(path.gsub(/^#{p.rubyforge_name}\/?/,''), 'rdoc')
  p.rsync_args = '-av --delete --ignore-errors'
end

require 'newgem/tasks' # load /tasks/*.rake
Dir['tasks/**/*.rake'].each { |t| load t }

# TODO - want other tests/tasks run by default? Add them to the list
task :default => [:package, :spec]