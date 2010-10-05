module CIM
  class Qualifier
    attr_reader :declaration, :value, :flavor
    def initialize declaration, value = nil, flavor = nil
      raise "Not a CIM::QualifierDeclaration: #{declaration.inspect}" unless declaration.is_a?(CIM::QualifierDeclaration)
      @declaration = declaration
      @value = value
      @flavor = flavor
    end
    def == q
      #	puts "CIM::Qualifier ->#{self} == #{q.inspect}"
      case q
      when CIM::Qualifier
	(@declaration == q.declaration) &&
	(@value == q.value) &&
	(@flavor == q.flavor)
      when CIM::QualifierDeclaration
	@declaration == q  
      when Symbol
	q.to_s.downcase == @declaration.name.downcase && @value.nil? && @flavor.nil?
      else
	false
      end
    end
    def name
      @declaration.name
    end
    def type
      @declaration.type
    end
    def to_sym
      @declaration.downcase.to_sym
    end
    def to_s
      s = "#{@declaration.name.capitalize}"
      case @value
      when nil:
      when Array:
	s << " {#{@value.join(', ')}}"
      else
	s << "(#{@value.inspect})"
      end
      s << " #{@flavor}" if @flavor
      s
    end
  end
end
