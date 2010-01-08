module CIM
  module Meta
    class Qualifier < NamedElement
      
      attr_reader :type, :value, :scope, :flavor, :default
      
      def initialize name, type = :bool, value = nil, scope = nil, flavor = nil, default = false
	@type = (type.kind_of? Type) ? type : Type.new(type)
	@value = value
	@scope = scope
	@flavor = flavor
	@default = (default.nil? || default.is_a?(CIM::Meta::Variant)) ? default : CIM::Meta::Variant.new(@type, default)
	super name
      end

      def == q
	(@name == q.name) && (@type == q.type)
      end

      def to_sym
	@name.to_sym
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
