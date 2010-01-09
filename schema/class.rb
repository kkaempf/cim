module CIM
  module Schema
    require File.dirname(__FILE__) + "/../schema/qualifier"
    class Class < CIM::Meta::NamedElement
      attr_reader :qualifiers, :alias_name, :superclass, :features
      def initialize name, qualifiers, alias_name, superclass, features
	@qualifiers = qualifiers
	@alias_name = alias_name
	@superclass = superclass
	features = nil if features.is_a?(Array) && features.empty?
	@features = features
#	puts "CIM::Schema::Class.new(#{@features})"
	super name
      end
      def to_s
	s = ""
	s << "[#{@qualifiers.join(', ')}]\n" if @qualifiers
	s << "class #{@name}"
	s << " AS #{@alias_name}" if @alias_name
	s << " : #{@superclass}" if @superclass
	s << " {"
	if @features
	  f = @features.join(";\n  ")
	  s << "\n  #{f};\n" 
	end
	s << "}"
      end
    end
  end
end
