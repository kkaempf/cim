module CIM
  module Meta
    class Qualifier < NamedElement
      
      attr_reader :type, :default, :scope, :flavor
      
      def initialize name, type = :bool, default = false, scope = nil, flavor = nil
	@type = (type.kind_of? Type) ? type : Type.new(type)
	@default = (default.nil? || default.is_a?(CIM::Meta::Variant)) ? default : CIM::Meta::Variant.new(@type, default)
	@scope = scope
	@flavor = flavor
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
