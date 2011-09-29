# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cim/version"

Gem::Specification.new do |s|
  s.name        = "cim"
  s.version     = CIM::Version::VERSION

  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Klaus Kämpf"]
  s.email       = ["kkaempf@suse.de"]
  s.homepage    = "https://github.com/kkaempf/cim"
  s.summary     = %q{A pure-Ruby implementation of the CIM meta model}
  s.description = %q{Instances of Cim classes are used to define a CIM
schema, often represented as a .mof file. See
http://www.dmtf.org/standards/cim and
http://www.dmtf.org/education/mof for details}
  
  s.rubyforge_project = "cim"

  s.files         = `git ls-files`.split("\n")
  s.files.reject! { |fn| fn == '.gitignore' }
  s.extra_rdoc_files    = Dir['README*', 'TODO*', 'CHANGELOG*']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
