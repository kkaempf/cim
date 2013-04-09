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
  #
  # A Property defines a data member of a Class.
  #
  # For method members, see Method.
  #
  class Property < CIM::ClassFeature
    attr_reader :default
    #
    # Create a Property with type (Type) and name (String), optional QualifierSet and default value
    #
    # call-seq:
    #   Property.new(:boolean, "flag")
    #   Property.new(:boolean, "flag", qualifier_set)
    #   Property.new(:boolean, "flag", qualifier_set, true)
    #
    def initialize type, name, qualifier_set=nil, default=nil
      @default = default
      super type, name, qualifier_set
    end
    #
    # Makes a Property recognizable in the set of Class features.
    #
    def property?
      true
    end
    #
    # Check for qualifiers
    #
    #  # check for existance
    #  element.qualifier? -> true or false
    #
    #  # check value
    #  element.description -> String or nil
    #
    def method_missing name, *args
      if name.to_s[-1,1] == "?"
        @qualifiers && @qualifiers.include?(name.to_s[0...-1])
      else
        (@qualifiers[name].value || @qualifiers[name].declaration.default) rescue nil
      end
    end
  end
end

