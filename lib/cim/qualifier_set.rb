#
# cim/qualifier_set.rb - class CIM::QualifierSet
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  #
  # Set of Qualifier
  #
  class QualifierSet < ::Array
    def initialize *args
      super 0
      args.flatten.each do |q|
	case q
	when QualifierDeclaration: q = Qualifier.new q
	when Qualifier:
	else
	  q = Qualifier.new(QualifierDeclaration.new q)
	end
	self << q
      end
    end
    #
    # check if qualifier exists
    #
    # call-seq:
    #   qualifier_set.includes?(qualifier) => bool
    #   qualifier_set.includes?(qualifier_declaration) => bool
    #   qualifier_set.includes?(:description) => bool
    #   qualifier_set.includes?("description", :string) => bool
    #
    def includes? qualifier,type=nil
      (self[qualifier,type]) ? true : false
    end
    alias include? includes?
    #
    # get qualifier by name and type
    #
    def [] qualifier,type=nil
      self.each do |q|
	unless type.nil?
	  next unless q.type == type
	end
#	puts "#{q} == #{qualifier}<#{type}>"
	return q if case qualifier
                       when CIM::Qualifier
			 q == qualifier.declaration
		       when CIM::QualifierDeclaration
			 q == qualifier
		       when String
			 q.declaration == qualifier
		       when Symbol
			 q.declaration == qualifier
		       else
			 raise "Unknown parameter in #{self.class}[]"
		       end
      end
      nil
    end
    #
    # returns a string representation in MOF syntax format
    #
    def to_s
      return "" if self.empty?
      q = self.join(", ")
      return "[#{q}]"
    end
  end
end
