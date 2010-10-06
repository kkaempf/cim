#
# cim/named_element.rb
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  class NamedElement
    attr_reader :name, :characteristics
    def initialize name
      raise "NamedElement must have a name" unless name
      @name = name.to_s
      @characteristics = []
    end
    def << qualifier
      @characteristics << qualifier
    end
    def has? qualifier
      @characteristics.include? qualifier
    end
  end
end

