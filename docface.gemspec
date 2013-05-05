require File.join(File.dirname(__FILE__), 'lib', 'docface', 'version')

Gem::Specification.new do |s|
  s.name        = 'docface'
  s.version     = DocFace::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = '2013-05-01'
  s.summary     = "A markdown documentation generator/viewer."
  s.description = "View your markdown files as a structured website."
  s.authors     = ["Bryan Brandau"]
  s.email       = 'agent462@gmail.com'
  s.has_rdoc    = false

  s.homepage    ='http://github.com/agent462/DocFace'
  s.add_dependency('rainbow', '1.1.4')
  s.add_dependency('trollop', '2.0')
  s.add_dependency('kramdown', '1.0.1')
  s.add_dependency('coderay', '1.0.9')

  s.files         = Dir.glob('{public,bin,lib}/**/*') + %w[docface.gemspec README.md]
  s.executables   = Dir.glob('bin/**/*').map { |file| File.basename(file) }
  s.require_paths = ['lib']
end
