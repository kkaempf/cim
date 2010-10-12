#
# cim/qualifier_declaration.rb
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
  # * name
  # * type (defaults to bool)
  # * default value (defaults to false)
  # * scope (where the qualifier can be used)
  # * flavor (how the qualifier is applied)
  #
  #
  class QualifierDeclaration < NamedElement

    attr_reader :type, :default, :scope, :flavor
    #
    # Create a new QualifierDeclaration
    #
    def initialize name, type = :bool, default = false, scope = nil, flavor = nil
      @type = (type.kind_of? Type) ? type : Type.new(type)
      @default = (default.nil? || default.is_a?(CIM::Variant)) ? default : CIM::Variant.new(@type, default)
      @scope = scope
      @flavor = flavor
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
    # return a string representation in MOF syntax format
    #
    def to_s
      s = "Qualifier #{@name} : #{@type}"
      s << " = #{@default}" if @default
      s << ",\n\t#{@scope}" if @scope
      s << ",\n\t#{@flavor}" if @flavor
      s
    end
  end
end
