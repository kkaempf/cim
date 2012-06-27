#
# cim.rb
#
# A pure-Ruby implementation of the CIM meta schema.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

#
# The CIM Ruby gem is an implementation of the Common Information Model (CIM) meta schema[1]
#
# = About
#
# The Common Information Model provides a common definition of management
# information for systems, networks, applications and services.[2]
#
# The CIM meta schema is used to describe elements of the CIM model, like
# types (CIM::Type), properties (CIM::Property), methods (CIM::Method)
# and classes (CIM::Class).
#
# Elements of the CIM model can be defined as text files using the Managed
# Object Format (MOF)[3] or by inspection on a running CIM Object Manager (CIMOM)[4]
# 
# Primary users of the CIM gem are the MOF gem [5], a parser for MOF files,
# and ruby-sfcc[6], a Ruby CIM client api.
#
# = Usage
#   require 'cim'
#
# = Links
# 1. http://www.wbemsolutions.com/tutorials/CIM/metaschema.html
# 2. http://www.dmtf.org/standards/cim
# 3. http://www.wbemsolutions.com/tutorials/CIM/cim-mof.html
# 4. http://www.wbemsolutions.com/tutorials/CIM/glossary.html#c-gloss
# 5. http://github.com/kkaempf/mof
# 6. http://github.com/dmacvicar/ruby-sfcc
#

module CIM
  VERSION = '1.4'
  require 'cim/type'
  require 'cim/variant'
  require 'cim/qualifier_flavors'
  require 'cim/qualifier_scopes'
  require 'cim/named_element'
  require 'cim/qualifier_declaration'
  require 'cim/qualifier'
  require 'cim/qualifier_set'
  require 'cim/class_feature'
  require 'cim/property'
  require 'cim/reference'
  require 'cim/method'
  require 'cim/class'
end
