#
# cim/qualifiers.rb - class CIM::Qualifiers
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  # Array of CIM::Qualifier
  class Qualifiers < ::Array
    #
    # check if qualifier exists
    #
    alias array_include? include?
    def include? q,type=:null
      #	puts "#{self}.include? #{q}:#{type}"
      case q
      when CIM::Qualifier
	q = q.definition
      when CIM::QualifierDeclaration
	# nothing
      when String
	q = CIM::QualifierDeclaration.new(q,type)
      when Symbol
	q = CIM::QualifierDeclaration.new(q,type)
      else
	raise "Unknown parameter in #{self.class}.include?"
      end
      self.array_include? q
    end
    #
    # get qualifier by name and type
    #
    alias array_access []
    def [] q,type=:null
      case q
      when Fixnum
	return self.array_access[q]
      when CIM::Qualifier
	q = q.definition
      when CIM::QualifierDeclaration
	# nothing
      when String
	q = CIM::QualifierDeclaration.new(q,type)
      when Symbol
	q = CIM::QualifierDeclaration.new(q,type)
      else
	raise "Unknown parameter in #{self.class}.[]"
      end
      i = self.index(q)
      return self.array_access(i) if i
      i
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
