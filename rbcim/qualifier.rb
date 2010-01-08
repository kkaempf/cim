module CIM
  module Meta
    class Qualifier < NamedElement
      
      attr_reader :type, :value, :scope, :flavor, :default
      
      def initialize name, type, value, scope, flavor, default
	@type = (type.kind_of? Type) ? type : Type.new(type)
	@value = value
	@scope = scope
	@flavor = flavor
	@default = (default.nil? || default.is_a?(CIM::Meta::Variant)) ? default : CIM::Meta::Variant.new(@type, default)
	super name
      end

      def to_s
	s = "Qualifier #{@name} : #{@type}"
	s << " = #{@default}" if @default
	s << ",\n\t#{@scope}" if @scope
	s << ",\n\t#{@flavor}" if @flavor
	s
      end
    end
  end
end
