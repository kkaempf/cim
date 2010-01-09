module CIM
  module Meta
    # Shared between Property and Method
    class Feature < NamedElement
      attr_reader :type, :qualifiers
      def initialize type, name, qualifiers
	@type = (type.is_a? CIM::Meta::Type) ? type : CIM::Meta::Type.new(type)
	@qualifiers = qualifiers
	super name
      end
      def to_s
	s = ""
	s << "#{@qualifiers}\n  " if @qualifiers
	s << "#{@type} #{@name}"
	s
      end
    end
  end
end
