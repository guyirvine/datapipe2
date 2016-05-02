require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

task :build do
  `gem build datapipe2.gemspec`
end

task :install do
  Rake::Task['build'].invoke
  cmd = "sudo gem install ./#{Dir.glob('datapipe2*.gem').sort.pop}"
  p "cmd: #{cmd}"
  `#{cmd}`
end

desc 'Run tests'
task :default => :install
