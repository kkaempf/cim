module CIM
  class Qualifier
    attr_reader :definition, :value, :flavor
    def initialize definition, value = nil, flavor = nil
      raise "Not a CIM::Meta::Qualifier definition: #{definition.inspect}" unless definition.is_a?(CIM::Meta::Qualifier)
      @definition = definition
      @value = value
      @flavor = flavor
    end
    def == q
      #	puts "CIM::Schema::Qualifier ->#{self} == #{q.inspect}"
      case q
      when CIM::Schema::Qualifier
	(@definition == q.definition) &&
	(@value == q.value) &&
	(@flavor == q.flavor)
      when CIM::Meta::Qualifier
	@definition == q  
      when Symbol
	q.to_s.downcase == @definition.name.downcase && @value.nil? && @flavor.nil?
      else
	false
      end
    end
    def to_sym
      @definition.downcase.to_sym
    end
    def to_s
      s = "#{@definition.name.capitalize}"
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
