module CIM
  # Shared between Property and Method
  class ClassFeature < NamedElement
    attr_reader :type, :qualifiers
    def initialize type, name, qualifiers = nil
      @type = (type.is_a? CIM::Type) ? type : CIM::Type.new(type)
      qualifiers = nil if qualifiers.is_a?(::Array) && qualifiers.empty?
      @qualifiers = qualifiers
      super name
    end
    # if has key qualifier
    def key?
      @qualifiers && @qualifiers.include?(:key,:bool)
    end
    # if static (class-level) feature
    def static?
      false
    end
    # if property
    def property?
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
      when CIM::Array
	s << "#{@type.type} #{@name}[]"
      else
	s << "#{@type} #{@name}"
      end
      s
    end
  end
end
