#
# cim/qualifier_flavor.rb
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM

  class QualifierFlavorError < ArgumentError
    def initialize flavor
      @flavor = flavor
    end
    def to_s
      "#{@flavor} is not a valid qualifier flavor"
    end
  end

  class QualifierFlavors
    FLAVORS = [:amended, :enableoverride, :disableoverride, :restricted, :toinstance, :tosubclass, :translatable]
    attr_reader :flavors
    def initialize flavor
      @flavors = []
      self << flavor
    end
    def << flavor
      @flavors << normalize(flavor)
      self
    end
    def size
      @flavors.size
    end
    def include? flavor
      @flavors.include?(normalize flavor)
    end
    def normalize flavor
      flavor.downcase! if flavor.kind_of? String
      f = flavor.to_sym
      raise QualifierFlavorError.new("#{flavor}") unless FLAVORS.include? f
      f
    end
    def to_sym
      @flavors.first
    end
    def to_s
      "Flavor(#{@flavors.join(', ')})"
    end
  end
end
