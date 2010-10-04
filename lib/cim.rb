# cim
# A pure-Ruby implementation of the CIM metamodel
#
# Written by Klaus Kaempf <kkaempf@suse.de>
#

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Cim
  VERSION = '0.2.7'
  cim_dir = File.join(File.dirname(__FILE__),"cim")
  require cim_dir + '/meta/type'
  require cim_dir + '/meta/variant'
  require cim_dir + '/meta/flavor'
  require cim_dir + '/meta/scope'
  require cim_dir + '/meta/named_element'
  require cim_dir + '/meta/qualifier'
  require cim_dir + '/qualifier'
  require cim_dir + '/qualifiers'
  require cim_dir + '/meta/feature'
  require cim_dir + '/property'
  require cim_dir + '/reference'
  require cim_dir + '/method'
  require cim_dir + '/class'
  require cim_dir + '/association'
  require cim_dir + '/instance'
  require cim_dir + '/indication'
end
