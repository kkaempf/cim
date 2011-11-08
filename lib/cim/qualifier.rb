#
# cim/qualifier.rb - class CIM::Qualifier
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
  # Qualifier can be seen as an instance of QualifierDeclaration
  #
  class Qualifier
    def self.normalize type
      (type.is_a? self) ? type : self.new(type)
    end
    
    attr_reader :declaration, :value, :flavor
    #
    # call-seq:
    #   Qualifier.new qualifier_declaration
    #   Qualifier.new qualifier_declaration, value
    #   Qualifier.new qualifier_declaration, value, flavor
    #
    def initialize declaration, value = nil, flavor = nil
      raise "Not a CIM::QualifierDeclaration: #{declaration.inspect}" unless declaration.is_a?(CIM::QualifierDeclaration)
      @declaration = declaration
      # FIXME, check if the value type matches the declaration type
      @value = value
      @flavor = flavor
    end
    #
    # Check for equality against Qualifier, QualifierDeclaration, String, or Symbol
    #
    def == q
      #	puts "CIM::Qualifier ->#{self} == #{q.inspect}"
      case q
      when CIM::Qualifier
	(@declaration == q.declaration) &&
	(@value == q.value) &&
	(@flavor == q.flavor)
      when CIM::QualifierDeclaration
	@declaration == q  
      when String
	@declaration.name.downcase == q.downcase && @value.nil? && @flavor.nil?
      when Symbol
	self == q.to_s # recycle
      else
	false
      end
    end
    #
    # Name of qualifier (String)
    #
    def name
      @declaration.name
    end
    #
    # Type of qualifier (Type)
    #
    def type
      @declaration.type
    end
    #
    # Name of qualifier as symbol (Symbol)
    #
    def to_sym
      @declaration.to_sym
    end
    #
    # returns a string representation in MOF syntax format
    #
    def to_s
      s = "#{@declaration.name.capitalize}"
      case @value
      when nil
      when Array
	s << " {#{@value.join(', ')}}"
      else
	s << "(#{@value.inspect})"
      end
      s << " #{@flavor}" if @flavor
      s
    end
  end
end
