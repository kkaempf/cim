module CIM
  module Schema
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
	  q.to_s == @definition.name && @value.nil? && @flavor.nil?
	else
	  false
        end
      end
      def to_sym
	@definition.to_sym
      end
      def to_s
	s = "#{@definition.name.capitalize}"
	s << "(#{@value.inspect})" if @value
	s << " #{@flavor}" if @flavor
        s
      end
    end
  end
end
