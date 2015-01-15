#
# cim/type.rb - class CIM::Type, class CIM::Array, class CIM::ReferenceType
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#


module CIM
  #
  # Type represents a CIM basic type
  # 
  # The following basic types are known:
  # uint8::     Unsigned 8-bit integer
  # sint8::     Signed 8-bit integer
  # uint16::    Unsigned 16-bit integer
  # sint16::    Signed 16-bit integer
  # uint32::    Unsigned 32-bit integer
  # sint32::    Signed 32-bit integer
  # uint64::    Unsigned 64-bit integer
  # sint64::    Signed 64-bit integer
  # string::    UCS-2 string
  # boolean::   Boolean
  # real32::    IEEE 4-byte floating-point
  # real64::    IEEE 8-byte floating-point
  # dateTime::  A string containing a date-time
  # reference:: Strongly typed reference
  # char16::    16-bit UCS-2 character
  # void::      -- allowed for WMI only
  #
  #
  class Type
    def self.normalize type
      (type.is_a? self) ? type : self.new(type)
    end
    
    TYPES = [:null,:void,:boolean,:char16,:string,:uint8,:sint8,:uint16,:sint16,:uint32,:sint32,:uint64,:sint64,:real32,:real64,:dateTime,:class,:reference,:array]
    NORMALIZE = {
      :bool => :boolean,
      :datetime => :dateTime
    }
    MATCHES = {
      :null => [],
      :void => [], # WMI
      :boolean => [],
      :char16 => [ :null, :string ],
      :string => [ :null ],
      :uint8 => [ :null ],
      :sint8 => [ :null ],
      :uint16 => [ :null, :uint8 ],
      :sint16 => [ :null, :sint8 ],
      :uint32 => [ :null, :uint8, :uint16 ],
      :sint32 => [ :null, :sint8, :sint16 ],
      :uint64 => [ :null, :uint8, :uint16, :sint32 ],
      :sint64 => [ :null, :sint8, :sint16, :sint32 ],
      :real32 => [ :null ],
      :real64 => [ :null, :real32 ],
      :dateTime => [ :null ],
      :class => [ :null ],
      :reference => [ :null ],
      :array => [ :null ]
    }
    attr_reader :type
    #
    # Basic types are created by-symbol or by-name
    #
    # CIM::Type.new(:boolean) == CIM::Type.new("boolean")
    #
    def initialize type
      type.downcase! if type.is_a? String
      @type = type.to_sym
      @type = NORMALIZE[@type] || @type
      raise TypeError.new("#{type}") unless TYPES.include? @type
    end
    def array?
      false
    end
    #
    # returns a string representation in MOF syntax format
    #
    def to_s
      @type.to_s
    end
    #
    # returns a symbol representation of the type
    #
    def to_sym
      @type
    end
    #
    # type equality
    #
    def == t
      case t
      when Type then t.type == @type
      when Symbol then t == @type
      when String then t.downcase == @type.to_s
      else
	false
      end
    end
    private
    def matches_value type,value
#      puts "matches_value >#{type}<{#{type.class}}.matches_value?>#{value.inspect}<{#{value.class}}"
      if value.class === Class
	return case value.to_s
          when "NilClass" then type == :null
	  when "FalseClass", "TrueClass" then type == :boolean
	  when "Integer", "Fixnum" then [:uint8,:sint8,:uint16,:sint16,:uint32,:sint32,:uint64,:sint64].include? type
	  when "Float" then [:real32, :real64].include? type
	  when "String" then type == :string
	  when "Array" then type.array?
	  else
	    false
	  end
      end
      case value
      when NilClass
	true
      when FalseClass, TrueClass
	type == :boolean
      when Integer, Fixnum
	case type
	when :uint8 then (0..255) === value
	when :sint8 then (-128..127) === value
	when :uint16 then (0..65535) === value
	when :sint16 then (-32768..32767) === value
	when :uint32 then (0..4294967295) === value
	when :sint32 then (-2147483648..2147483647) === value
	when :uint64 then (0..18446744073709551615) === value
	when :sint64 then (-9223372036854775808..9223372036854775807) === value
	else
	  false
	end
      when Float
	case type
	when :real32, :real64 then true
	else
	  false
	end
      when String
	type == :string
      else
	false
      end
    end
    public
    #
    # check if another Type or Variant matches
    #
    def matches? x
#      	puts "Type#matches? : >#{self}<{#{self.class}}.matches?>#{x.inspect}<{#{x.class}}"
      case x
      when CIM::Type, CIM::Variant
	return true if x.type == @type
	return true if MATCHES[@type].include? x.type
	false
      when ::Symbol
        return true if @type == x
        return true if MATCHES[@type].include? x
        false
      when ::Array
	return false unless self.is_a? CIM::Array
	x.each do |v|
	  return false unless matches_value @type,v
	end
	true
      else
	matches_value @type, x
      end
    end
  end
  
  #
  # Array represents an array of identical typed value
  # 
  #  
  class Array < Type
    attr_reader :size
    #
    # Arrays are initialized by size and type
    # Passing 0 (zero) as the size creates an unlimited array
    #
    def initialize size, type
      @size = size
      super type
    end
    def array?
      true
    end
    #
    # An array is equal to any other array, regardless of the enclosed type
    #
    def == t
      t == :array
    end
    #
    # returns a string representation of the array type
    #
    def to_s
      if @size > 0
	"#{super}[#{@size}]"
      else
	"#{super}[]"
      end
    end
  end
  
  #
  # ReferenceType is a strongly typed reference to a class
  # 
  #
  class ReferenceType < Type
    attr_reader :name
    #
    # Creates a strongly typed reference to class +name+
    #
    def initialize name
      @name = name
      super "class"
    end
    #
    # returns a string representation of the reference type
    #
    def to_s
      "#{@name} ref"
    end
  end
end
