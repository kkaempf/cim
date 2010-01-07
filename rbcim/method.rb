module CIM
  module Meta
    class Method < NamedElement
      attr_reader :type
      def initialize type,name,description=nil,*qualifiers
	@type = Type.new type
	super name,description,*qualifiers
      end
      def to_s
	"#{@type_to_s} #{@name}()"
      end
    end
  end
end
