module CIM
  module Meta
    class Property < Feature
      attr_reader :display_name
      def initialize type, display_name=nil, name=nil, description=nil, *qualifiers
	raise "Property must have name" unless display_name || name
	@display_name = display_name
	super type, name||display_name, description, *qualifiers
      end
    end
  end
end
