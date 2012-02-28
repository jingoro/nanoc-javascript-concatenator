# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["John Nishinaga"]
  gem.email         = ["jingoro@casa-z.org"]
  gem.description   = %q{Nanoc JavaScript concatenator filter}
  gem.summary       = %q{A simple way to concatenate JavaScript files in Nanoc}
  gem.homepage      = "https://github.com/jingoro/nanoc-javascript-concatenator"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "nanoc-javascript-concatenator"
  gem.require_paths = ["lib"]
  gem.version       = '0.0.1'

  gem.add_dependency 'nanoc', '>= 3.3.0'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'bluecloth'
end
