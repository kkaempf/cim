#
# cim/class_feature.rb - class CIM::ClassFeature
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  #
  # ClassFeature is the base class for Class Property and Method
  #
  # A ClassFeature has a type (Type), name (String), and optional Qualifiers
  #
  # Access to ClassFeature attributes is *protected*, use the derived
  # classes Property, Method and Reference
  #
  class ClassFeature < NamedElement
    attr_reader :type
    #
    # if Property
    #
    def property?
      false
    end
    #
    # if Method
    #
    def method?
      false
    end
    #
    # if Reference
    #
    def reference?
      false
    end
    protected
    def initialize type, name, qualifiers = nil
    # :notnew:
      @type = CIM::Type.normalize type
      super name, qualifiers
    end
    #
    # returns a string representation in MOF syntax format
    #
    def to_s
      s = ""
      s << "#{@qualifiers}\n  " if @qualifiers
      case @type
      when CIM::Array
	s << "#{@type.type} #{@name}[]"
      else
	s << "#{@type} #{@name}"
      end
      s
    end
    #
    # Check for qualifiers
    #
    #  # check for existance
    #  property.qualifier? -> true or false
    #
    #  # check value
    #  property.description -> String or nil
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
