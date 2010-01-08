module CIM
  module Meta
    class NamedElement
      attr_reader :name, :characteristics
      def initialize name
	@name = name.to_s
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