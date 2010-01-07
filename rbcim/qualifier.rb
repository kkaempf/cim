module CIM
  module Meta
    class Qualifier < NamedElement
      
      attr_reader :type, :value, :scope, :flavor, :default
      
      def initialize name, type, value, scope, flavor, default
	@type = (type.kind_of? Type) ? type : Type.new(type)
	@value = value
	@scope = scope
	@flavor = flavor
	@default = default
	super name
      end

      def to_s
	"Qualifier #{@name} : #{@type} = #{@default},\n\t#{@scope},\n\t#{@flavor}"
      end
    end
  end
end
