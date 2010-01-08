module CIM
  module Meta
    # A Variant is a typed value
    class Variant
      attr_reader :type, :value
      def initialize type = :null, value = nil
	@type = (type.kind_of? CIM::Meta::Type) ? type : CIM::Meta::Type.new(type)
	@value = value unless value == :null
      end
      def to_s
	if @type == :null
	  "null"
	else
	  "#{@value.inspect}"
	end
      end
    end
  end
end
