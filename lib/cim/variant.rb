#
# cim/variant.rb - class CIM::Variant
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  #
  # A Variant is a typed value
  #
  class Variant
    attr_reader :type, :value
    #
    # Creates a typed value
    #
    # +type+: See CIM::Type
    # +value+: A Ruby value
    #
    # No attempt is made to check if the type matches the value.
    #
    def initialize type = :null, value = nil
      @type = (type.kind_of? CIM::Type) ? type : CIM::Type.new(type)
      @value = value unless value == :null
    end
    #
    # Checks equality of the Variant with a Ruby value or another Variant
    #
    def == v
#      $stderr.puts "<#{@type}>#{self} == #{v.class}"
      return false unless self.is_a?(v)
      case v
      when NilClass then     @value.nil?
      when FalseClass then   !@value
      when TrueClass then    @value
      when String then       @value == v
      when Integer then      @value == v
      when Float then        @value == v
      when CIM::Variant then @value == v.value
      else
	false
      end			
    end
    #
    # Check type against Ruby class
    #
    def is_a? klass
#      puts "Variant#is_a? : #{self.inspect} is_a #{klass.class}:#{klass.inspect}"
      case klass
      when NilClass      then @type.matches? :null
      when FalseClass    then @type.matches? :boolean
      when TrueClass     then @type.matches? :boolean
      when Integer       then @type.matches?(:uint64) || @type.matches?(:sint64) 
      when Float         then @type.matches? :real32
      when Symbol        then @type.matches? klass
      when String        then
        @type.matches? :string
      when CIM::Variant  then @type.matches? klass.type
      else
        if klass == Integer
          @type.matches?(:uint64) || @type.matches?(:sint64) 
        elsif klass == Float
          @type.matches? :real32
        elsif klass == String
          @type.matches? :string
        else
#          puts "Nothing matches #{klass}:#{klass.inspect}"
          false
        end
      end
    end
    #
    # returns a string representation in MOF syntax format
    #
    def to_s
      if @type == :null
	"null"
      else
	"#{@value.inspect}"
      end
    end
  end
end
