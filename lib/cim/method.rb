#
# cim/method.rb - class CIM::Method
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  class Method < CIM::ClassFeature
    attr_reader :parameters
    def initialize type, name, qualifiers = nil, parameters = nil
      parameters = nil if parameters.kind_of?(::Enumerable) && parameters.empty?
      @parameters = parameters
      qualifiers = [ qualifiers ] unless qualifiers.kind_of?(Enumerable)
      super type,name,qualifiers
    end
    def method?
      true
    end
    #
    # returns a string representation in MOF syntax format
    #
    def to_s
      p = @parameters.join(", ") if @parameters
      "#{super}(#{p})"
    end
  end
end
