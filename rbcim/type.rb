module CIM
  module Meta
    class Type
      TYPES = [:null,:bool,:char16,:string,:uint8,:sint8,:uint16,:sint16,:uint32,:sint32,:uint64,:sint64,:real32,:real64,:datetime,:class,:reference,:array]
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
  end
end
