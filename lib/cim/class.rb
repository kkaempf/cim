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
    attr_reader :alias_name, :superclass
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
#    	    if qualifiers and qualifiers.include?(:association, :boolean)
	      # FIXME: 'association' must be first
              # Context:
	      #
	      # The remaining qualifier list must not include
	      # the ASSOCIATION qualifier again. If the
	      # association has no super association, then at
	      # least two references must be specified! The
	      # ASSOCIATION qualifier may be omitted in
	      # sub associations.
#	      result = CIM::Association.new(val[2],qualifiers,val[3],val[4],features)
#	    elsif qualifiers and qualifiers.include?(:indication, :boolean)
	      # FIXME: 'indication' must be first
	      # FIXME: features must not include references
#	      result = CIM::Indication.new(val[2],qualifiers,val[3],val[4],features)
#	    else

    #
    def initialize name, qualifiers = nil, alias_name = nil, superclass = nil, features = nil
      @alias_name = alias_name
      @superclass = superclass
      features = nil if features.kind_of?(::Enumerable) && features.empty?
      @features = features
      #	puts "CIM::Class.new(#{@features})"
      super name, qualifiers
    end
    #
    # Ensure features can be enumerated
    #
    def features
      @features || []
    end
    #
    # Iterate over features flagged as keys
    #
    def each_key
      features.each do |f|
	yield f if f.key?
      end
    end
    #
    # true if class has instances (instance provider)
    #
    def instance?
      features.size > 0
    end
    #
    # true if class has methods (method provider)
    #
    def method?
      features.each do |f|
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
      qualifiers.include? :association
    end
    #
    # true if class has indications (indication provider)
    #
    def indication?
      qualifiers.include? :indication
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
