module CIM
  module Meta
    class Method < NamedElement
      def initialize type,name,description=nil,*qualifiers
	super type,name,description,*qualifiers
      end
      def to_s
	"#{super}()"
      end
    end
  end
end
