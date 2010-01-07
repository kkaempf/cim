module CIM
  module Meta
    class FlavorError < ArgumentError
      def initialize flavor
	@flavor = flavor
      end
      def to_s
	"#{@flavor} is not a valid Flavor"
      end
    end
    class Flavors
      FLAVORS = [:enableoverride, :disableoverride, :restricted, :tosubclass, :translatable]
      attr_reader :flavors
      def initialize flavor
	@flavors = []
	puts "Flavors.new(#{flavor})"
	self << flavor
      end
      def << flavor
	flavor.downcase! if flavor.kind_of? String
	f = flavor.to_sym
	raise FlavorError, "#{flavor}" unless FLAVORS.include? f
	@flavors << f
	self
      end
      def to_sym
	@flavors.first
      end
      def to_s
	"Flavor(#{@flavors.join(', ')})"
      end
    end
  end
end
