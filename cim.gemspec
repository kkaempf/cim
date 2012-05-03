# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cim"

Gem::Specification.new do |s|
  s.name        = "cim"
  s.version     = CIM::VERSION

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

  s.add_development_dependency('rake')
  s.add_development_dependency('bundler')

  s.files         = Dir.glob("lib/**/*.rb")
  s.extra_rdoc_files    = Dir['README*', 'TODO*', 'CHANGELOG*', 'LICENSE']
  s.require_paths = ["lib"]
end
