module CIM
  module Meta
    class NamedElement
      attr_reader :name, :characteristics
      def initialize name
	@name = name
	@characteristics = []
      end
      def << qualifier
	@characteristics << qualifier
      end
      def has? qualifier
	@characteristics.include? qualifier
      end
    end
  end
end