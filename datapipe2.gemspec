Gem::Specification.new do |s|
  s.name        = 'datapipe2'
  s.version     = '0.0.2'
  s.date        = '2016-05-02'
  s.summary     = "DataPipe2"
  s.description = "zero to one for moving data"
  s.authors     = ["Guy Irvine"]
  s.email       = 'guy@guyirvine.com'
  s.files       = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.homepage    = 'http://rubygems.org/gems/datapipe2'
#  s.add_dependency( "json" )
#  s.add_dependency( "fluiddb" )
#  s.add_dependency( "parse-cron" )
  s.executables << 'datapipe2'
end
