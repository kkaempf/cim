module CIM
  module Meta
    
    class MetaElementError < ArgumentError
      def initialize element, msg = nil
	@element = element
	super msg
      end
      def to_s
	"#{@element} is not a valid meta element for scopes"
      end
    end
    
    class Scope
      META_ELEMENTS = [ :schema, :class, :association, :indication, :qualifier, :property, :reference, :method, :parameter, :any ]
      attr_reader :elements
      def initialize element = :any
	@elements = []
	self << element
      end
      def << element
	element.downcase! if element.is_a?(String)
	e = element.to_sym
	raise MetaElementError(element) unless META_ELEMENTS.include?(e)
	@elements << e
	self
      end
      def has? qualifier
	@elements.include? qualifier
      end
      def to_s
	"Scope(#{@elements.join(', ')})"
      end
      def to_sym
	@elements.first
      end
    end
  end
end
