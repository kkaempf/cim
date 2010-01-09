# rbcim
# A pure-Ruby implementation of the CIM metamodel
#
# Written by Klaus Kaempf
#

rbcim_dir = File.dirname(__FILE__)
require rbcim_dir + '/meta/type'
require rbcim_dir + '/meta/variant'
require rbcim_dir + '/meta/flavor'
require rbcim_dir + '/meta/scope'
require rbcim_dir + '/meta/named_element'
require rbcim_dir + '/meta/qualifier'
require rbcim_dir + '/schema/qualifier'
require rbcim_dir + '/schema/qualifiers'
require rbcim_dir + '/meta/feature'
require rbcim_dir + '/schema/property'
require rbcim_dir + '/schema/reference'
require rbcim_dir + '/schema/method'
require rbcim_dir + '/schema/class'
require rbcim_dir + '/schema/association'
require rbcim_dir + '/schema/instance'
require rbcim_dir + '/schema/indication'
