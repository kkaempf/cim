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
      args.each do |q|
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
      self.each do |q|
	unless type.nil?
	  next unless q.type == type
	end
#	puts "#{q} == #{qualifier}<#{type}>"
	return true if case qualifier
                       when CIM::Qualifier
			 q == qualifier.declaration
		       when CIM::QualifierDeclaration
			 q == qualifier
		       when String
			 q.declaration == qualifier
		       when Symbol
			 q.declaration == qualifier
		       else
			 raise "Unknown parameter in #{self.class}.include?"
		       end
      end
      false
    end
    alias include? includes?
    #
    # get qualifier by name and type
    #
    alias array_access []
#    def [] q,type=:null
#      case q
#      when Fixnum
#	return self.array_access[q]
#      when CIM::Qualifier
#	q = q.definition
#      when CIM::QualifierDeclaration
#	# nothing
#      when String
#	q = CIM::QualifierDeclaration.new(q,type)
#      when Symbol
#	q = CIM::QualifierDeclaration.new(q,type)
#      else
#	raise "Unknown parameter in #{self.class}.[]"
#      end
#      i = self.index(q)
#      return self.array_access(i) if i
#      i
#    end
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
