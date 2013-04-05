$:.push File.expand_path("../lib", __FILE__)
require 'rhopalic/version'

Gem::Specification.new do |s|
  s.name        = 'rhopalic'
  s.version     = Rhopalic::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Nik Haldimann']
  s.email       = ['nhaldimann@gmail.com']
  s.homepage    = 'https://github.com/nikhaldi/rhopalic-ruby'
  s.summary     = 'Detects rhopalic phrases'
  s.description = 'Detects rhopalic phrases'

  s.add_runtime_dependency 'lingua', '~> 0.6.2'
  s.add_development_dependency 'param_test', '~> 0.0.2'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
