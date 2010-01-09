module CIM
  module Meta
    class Type
      TYPES = [:null,:bool,:char16,:string,:uint8,:sint8,:uint16,:sint16,:uint32,:sint32,:uint64,:sint64,:real32,:real64,:datetime,:class,:reference,:array]
      MATCHES = {
	:null => [],
	:bool => [],
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
	:datetime => [ :null ],
	:class => [ :null ],
	:reference => [ :null ],
	:array => [ :null ]
      }
      attr_reader :type
      def initialize type
	type.downcase! if type.is_a? String
	@type = type.to_sym
	raise TypeError, "#{type}" unless TYPES.include? @type
      end
      def to_s
	@type.to_s
      end
      def to_sym
	@type
      end
      def == t
	case t
	when Type: t.type == @type
	when Symbol: t == @type
	else
	  false
	end
      end
      private
      def matches_value type,value
#	puts ">#{type}<{#{type.class}}.matches_value?>#{value.inspect}<{#{value.class}}"
	case value
	when NilClass
	  true
	when FalseClass, TrueClass
	  type == :bool
	when Integer
	  case type
	  when :uint8: (0..255) === value
	  when :sint8: (-128..127) === value
	  when :uint16: (0..65535) === value
	  when :sint16: (-32768..32767) === value
	  when :uint32: (0..4294967295) === value
	  when :sint32: (-2147483648..2147483647) === value
	  when :uint64: (0..18446744073709551615) === value
	  when :sint64: (-9223372036854775808..9223372036854775807) === value
	  else
	    false
	  end
	when Float
	  case type
	  when :real32: value.to_i.size == 4
	  when :real64: true
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
      def matches? x
#	puts ">#{self}<{#{self.class}}.matches?>#{x.inspect}<{#{x.class}}"
	case x
	when CIM::Meta::Type, CIM::Meta::Variant
	  return true if x.type == @type
	  return true if MATCHES[@type].include? x.type
	  false
	when ::Array
	  return false unless self.is_a? CIM::Meta::Array
	  x.each do |v|
	    return false unless matches_value @type,v
	  end
	  true
	else
	  matches_value @type, x
	end
      end
    end
    class Array < Type
      attr_reader :size
      def initialize size, type
	@size = size
	super type
      end
      def to_s
	if @size > 0
	  "#{super}[#{@size}]"
	else
	  "#{super}[]"
	end
      end
    end
    class Reference < Type
      attr_reader :name
      def initialize name
	@name = name
	super :class
      end
      def to_s
	"#{@name} ref"
      end
    end
  end
end
