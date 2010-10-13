#
# cim/property.rb - class CIM::Property
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  class Property < CIM::ClassFeature
    attr_reader :default
    def initialize type, name, qualifiers=nil, default=nil
      @default = default
      unless qualifiers.nil? || qualifiers.kind_of?(Enumerable)
	qualifiers = [ qualifiers ]
      end
      super type, name, qualifiers
    end
    def property?
      true
    end
  end
end

