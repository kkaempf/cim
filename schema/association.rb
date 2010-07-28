module CIM
  module Schema
    class Association < Class
      def initialize name, qualifiers, alias_name, superclass, features
	raise "Association needs 'association' qualifier" unless qualifiers.include?(:association)
	super name, qualifiers, alias_name, superclass, features
      end
      # true if class has associations (association provider)
      def association?
	true
      end
    end
  end
end
