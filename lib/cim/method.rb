#
# cim/method.rb - class CIM::Method
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  #
  # A Method defines a function member of a Class.
  #
  # For data members, see Property.
  #
  class Method < CIM::ClassFeature
    #
    # Create a Method with return type (Type) and name (String), optional Qualifiers and parameters (Property)
    #
    # call-seq:
    #   Method.new(:boolean, "do_something")
    #   Method.new(:boolean, "do_something", qualifiers)
    #   Method.new(:boolean, "do_something", qualifiers, parameters)
    #
    def initialize type, name, qualifiers = nil, parameters = nil
      @parameters = parameters
      super type,name,qualifiers
    end
    #
    # parameters accessor
    #
    def parameters
      @parameters || []
    end
    #
    # Makes a Method recognizable in the set of Class features.
    #
    def method?
      true
    end
    #
    # returns a string representation in MOF syntax format
    #
    def to_s
      p = parameters.join(", ")
      "#{super}(#{p})"
    end
    #
    # Check for qualifiers
    #
    #  # check for existance
    #  method.qualifier? -> true or false
    #
    #  # check value
    #  method.description -> String or nil
    #
    def method_missing name, *args
      if name.to_s[-1,1] == "?"
        @qualifiers && @qualifiers.include?(name.to_s[0...-1])
      else
        (@qualifiers[name].value || @qualifiers[name].declaration.default.value) rescue nil
      end
    end
  end
end
