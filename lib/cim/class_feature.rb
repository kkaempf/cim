#
# cim/class_feature.rb - class CIM::ClassFeature
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  # Shared between Property and Method
  class ClassFeature < NamedElement
    attr_reader :type
    def initialize type, name, qualifiers = nil
      @type = (type.is_a? CIM::Type) ? type : CIM::Type.new(type)
      super name, qualifiers
    end
    # if has key qualifier
    def key?
      @qualifiers && @qualifiers.include?(:key,:bool)
    end
    # if static (class-level) feature
    def static?
      false
    end
    # if property
    def property?
      false
    end
    # if method
    def method?
      false
    end
    # if reference
    def reference?
      false
    end
    #
    # returns a string representation in MOF syntax format
    #
    def to_s
      s = ""
      s << "#{@qualifiers}\n  " if @qualifiers
      case @type
      when CIM::Array
	s << "#{@type.type} #{@name}[]"
      else
	s << "#{@type} #{@name}"
      end
      s
    end
  end
end
