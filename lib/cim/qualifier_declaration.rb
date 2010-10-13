#
# cim/qualifier_declaration.rb - class CIM::QualifierDeclaration
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  #
  # A Qualifier is a modifier containing information to describe a Class, an Instance,
  # a Property, a Method or a parameter.
  #
  # A qualifier needs to be declared before it can be used.
  #
  # Typical qualifiers are e.g.
  # Description:: (string type) to add a textual information about an element of the CIM model.
  # Counter,Gauge:: to explain how a numeric value is to be interpreted
  # Deprecated:: to denote end-of-life for model elements
  # Min, Max:: (MinLen, MaxLen, MinValue, MaxValue) limits
  #
  # A QualifierDeclaration declares a qualifier by
  # name:: (String)
  # type:: (Type) (defaults to bool)
  # default value:: (Variant) (defaults to false)
  # scopes:: (QualifierScopes) (where the qualifier can be used)
  # flavor:: (QualifierFlavors) (how the qualifier is applied)
  #
  #
  class QualifierDeclaration < NamedElement

    attr_reader :type, :default, :scopes, :flavors
    #
    # Create a new QualifierDeclaration
    #
    def initialize name, type = :bool, default = false, scopes = nil, flavors = nil
      @type = (type.kind_of? Type) ? type : Type.new(type)
      @default = (default.nil? || default.is_a?(CIM::Variant)) ? default : CIM::Variant.new(@type, default)
      @scopes = scopes
      @flavors = flavors
      super name
    end
    #
    # Test for equality by comparing name and type
    #
    def == q
      #	puts "#{@name}:#{@type} == #{q.name}:#{q.type}"
      (@name.downcase == q.name.downcase) &&
        (@type.nil? || q.type.nil? || (@type == q.type))
    end
    #
    # return a symbol representation of the qualifier name
    #
    def to_sym
      @name.downcase.to_sym
    end
    #
    # returns a string representation in MOF syntax format
    #
    def to_s
      s = "Qualifier #{@name} : #{@type}"
      s << " = #{@default}" if @default
      s << ",\n\t#{@scopes}" if @scopes
      s << ",\n\t#{@flavors}" if @flavors
      s
    end
  end
end
