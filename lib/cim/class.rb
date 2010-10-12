#
# cim/class.rb
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  require File.join(File.dirname(__FILE__),"qualifier")
  class Class < CIM::NamedElement
    attr_reader :alias_name, :qualifiers, :superclass, :features
    def initialize name, qualifiers, alias_name, superclass, features
      @qualifiers = qualifiers
      @alias_name = alias_name
      @superclass = superclass
      features = nil if features.is_a?(Array) && features.empty?
      @features = features
      #	puts "CIM::Class.new(#{@features})"
      super name
    end
    def add_type t
      @ptype << t
    end
    # true if class has instances (instance provider)
    def instance?
      @features.size > 0
    end
    # true if class has methods (method provider)
    def method?
      @features.each do |f|
	case f
	when CIM::Method: return true
	end
      end
      false
    end
    # true if class has associations (association provider)
    def association?
      false
    end
    # true if class has indications (indication provider)
    def indication?
      false
    end
    #
    # returns a string representation in MOF syntax format
    #
    def to_s
      s = ""
      s << "[#{@qualifiers.join(', ')}]\n" if @qualifiers
      s << "class #{@name}"
      s << " AS #{@alias_name}" if @alias_name
      s << " : #{@superclass}" if @superclass
      s << " {"
      if @features
	f = @features.join(";\n  ")
	s << "\n  #{f};\n" 
      end
      s << "}"
    end
  end
end
