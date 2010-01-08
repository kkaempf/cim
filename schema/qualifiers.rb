module CIM
  module Schema
    # Array of CIM::Schema::Qualifier
    class Qualifiers < Array
      alias array_include? include?
      def include? q
	case q
	when CIM::Schema::Qualifier
	  self.array_include? q.definition
	when CIM::Meta::Qualifier
	  self.array_include? q
	when String
	  self.array_include? CIM::Meta::Qualifier.new(q)
	when Symbol
	  self.array_include? CIM::Meta::Qualifier.new(q)
	else
	end
      end
      def to_s
	unless self.empty?
	  q = self.join(", ")
	  return "[#{q}]"
	end
	""
      end
    end
  end
end
