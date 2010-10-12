#
# cim/variant.rb
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
      case v
      when NilClass:   @type == :null && @value.nil?
      when FalseClass: @type == :bool && !@value
      when TrueClass:  @type == :bool && @value
      when String:     @type == :string && @value == v
      when Integer:    @type == :int && @value == v
      when Float:      @type == :real && @value == v
      when CIM::Variant: @type == v.type && @value == v.value
      else
	false
      end			
    end
    #
    # Returns a string representation
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
