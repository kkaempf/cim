module CIM
  module Meta
    class Association < Class
      def initialize name, qualifiers, alias_name, superclass, features
	raise "Association needs 'association' qualifier" unless qualifiers.include?(:association)
	super name, qualifiers, alias_name, superclass, features
      end
    end
  end
end
