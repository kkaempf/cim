#
# cim/class.rb - class CIM::Class
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  require File.join(File.dirname(__FILE__),"qualifier")
  #
  # A Class is a central element in the object-oriented CIM schema
  #
  # Classes can be derived from other classes, creating a hierachical model.
  #
  # Classes have qualifiers to describe the class characteristics
  # and contain features (properties or methods).
  #
  class Class < CIM::NamedElement
    attr_reader :alias_name, :superclass, :features
    #
    # Creates a new Class with name (String), qualifiers, alias, superclass and features
    #
    # Features are class attributes, namely Property, Method, or Reference
    #
    # call-seq:
    #   Class.new("MyClass")
    #   Class.new("MyClass", qualifiers)
    #   Class.new("MyClass", qualifiers, "my_class")
    #   Class.new("MyClass", qualifiers, "my_class", "SuperClass")
    #   Class.new("MyClass", qualifiers, "my_class", "SuperClass", features)
    #
    def initialize name, qualifiers = nil, alias_name = nil, superclass = nil, features = nil
      @alias_name = alias_name
      @superclass = superclass
      features = nil if features.is_a?(Array) && features.empty?
      @features = features
      #	puts "CIM::Class.new(#{@features})"
      super name, qualifiers
    end
    #
    # true if class has instances (instance provider)
    #
    def instance?
      @features.size > 0
    end
    #
    # true if class has methods (method provider)
    #
    def method?
      @features.each do |f|
	case f
	when CIM::Method: return true
	end
      end
      false
    end
    #
    # true if class has associations (association provider)
    #
    def association?
      false
    end
    #
    # true if class has indications (indication provider)
    #
    def indication?
      false
    end
    #
    # returns a string representation in MOF syntax format
    #
    def to_s
      s = ""
      s << "[#{@qualifiers.join(', ')}]\n" if @qualifiers
      s << "class #{@name}"
      s << " AS #{@alias_name}" if @alias_name
      s << " : #{@superclass}" if @superclass
      s << " {"
      if @features
	f = @features.join(";\n  ")
	s << "\n  #{f};\n" 
      end
      s << "}"
    end
  end
end
