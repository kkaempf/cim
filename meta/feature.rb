module CIM
  module Meta
    # Shared between Property and Method
    class Feature < NamedElement
      attr_reader :type, :description, :qualifiers
      def initialize type, name, description=nil, *qualifiers
	@type = (type.is_a? CIM::Meta::Type) ? type : CIM::Meta::Type.new(type)
	@description = description
	@qualifiers = qualifiers
	super name
      end
      def to_s
	s = ""
	s << "[#{@description}]\n" if @description
	s << "#{@type} #{@name}"
	s << " : #{@qualifiers}" if @qualifiers
      end
    end
  end
end
