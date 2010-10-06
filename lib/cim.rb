#
# cim.rb
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Cim
  VERSION = '0.3.1'
  require 'cim/type'
  require 'cim/variant'
  require 'cim/qualifier_flavors'
  require 'cim/qualifier_scope'
  require 'cim/named_element'
  require 'cim/qualifier_declaration'
  require 'cim/qualifier'
  require 'cim/qualifiers'
  require 'cim/class_feature'
  require 'cim/property'
  require 'cim/reference'
  require 'cim/method'
  require 'cim/class'
  require 'cim/association'
  require 'cim/instance'
  require 'cim/indication'
end
