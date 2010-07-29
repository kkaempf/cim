module CIM
  module Meta
    # Shared between Property and Method
    class Feature < NamedElement
      attr_reader :type, :qualifiers
      def initialize type, name, qualifiers
	@type = (type.is_a? CIM::Meta::Type) ? type : CIM::Meta::Type.new(type)
	qualifiers = nil if qualifiers.is_a?(::Array) && qualifiers.empty?
	@qualifiers = qualifiers
	super name
      end
      # if static (class-level) feature
      def static?
	false
      end
      # if method
      def method?
	false
      end
      # if reference
      def reference?
	false
      end
      def to_s
	s = ""
	s << "#{@qualifiers}\n  " if @qualifiers
	case @type
	when CIM::Meta::Array
	  s << "#{@type.type} #{@name}[]"
        else
	  s << "#{@type} #{@name}"
        end
	s
      end
    end
  end
end
