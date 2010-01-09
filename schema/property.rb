module CIM
  module Schema
    class Property < CIM::Meta::Feature
      attr_reader :default
      def initialize type, name, qualifiers=nil, default=nil
	@default = default
	super type, name, qualifiers
      end
    end
  end
end
