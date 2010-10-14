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
    attr_reader :parameters
    #
    # Create a Method with return type (Type) and name (String), optional Qualifiers and parameters (Property)
    #
    # call-seq:
    #   Method.new(:bool, "do_something")
    #   Method.new(:bool, "do_something", qualifiers)
    #   Method.new(:bool, "do_something", qualifiers, parameters)
    #
    def initialize type, name, qualifiers = nil, parameters = nil
      parameters = nil if parameters.kind_of?(::Enumerable) && parameters.empty?
      @parameters = parameters
      super type,name,qualifiers
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
      p = @parameters.join(", ") if @parameters
      "#{super}(#{p})"
    end
  end
end
