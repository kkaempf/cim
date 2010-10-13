#
# cim/qualifier_flavor.rb - class CIM::QualifierFlavors, class CIM::QualifierFlavorError
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  #
  # QualifierFlavorError is raised during QualifierFlavors creation
  #
  class QualifierFlavorError < ArgumentError
    def initialize flavor
      @flavor = flavor
    end
    def to_s
      "#{@flavor} is not a valid qualifier flavor"
    end
  end
  #
  # Qualifier flavors are a fixed set. QualifierFlavors tracks which flavors are enabled for a specific QualifierDeclaration.
  #
  # Allowed flavors are
  #
  # amended:: Marks a qualifier value for localization (default: false)
  # enableoverride:: The qualifier can be overriden (in a subclass) (default: true)
  # disableoverride:: The qualifier can not be overriden (default: false)
  # restricted:: The qualifier only applies to the class in which it is declared (default: false)
  # toinstance:: 
  # tosubclass:: The qualifier is inherited by any subclass (default: true)
  # translatable:: Marks a qualifier value for localization (default: false)
  #
  class QualifierFlavors
    FLAVORS = [:amended, :enableoverride, :disableoverride, :restricted, :toinstance, :tosubclass, :translatable]
    attr_reader :flavors
    #
    # Create QualifierFlavors with an initial flavor. More flavors can be added through the << method.
    #
    # call-seq:
    #   QualifierFlavors.new :tosubclass => qualifier_flavors
    #   QualifierFlavors.new "tosubclass" => qualifier_flavors
    #   QualifierFlavors.new "ToSubClass" => qualifier_flavors
    #    
    # The flavor can be named as a string or a symbol.
    #
    def initialize flavor
      @flavors = []
      self << flavor
    end
    #
    # Add a flavor to the set
    # The flavor can be named as a string or a symbol.
    #
    # call-seq:
    #   qualifier_flavors << :tosubclass
    #   qualifier_flavors << "tosubclass"
    #   qualifier_flavors << "ToSubClass"
    #
    # Raises QualifierFlavorError if its not an allowed flavor
    #
    def << flavor
      @flavors << normalize(flavor)
      self
    end
    #
    # Number of flavors in the set
    #
    def size
      @flavors.size
    end
    #
    # Check if a specific flavor is included in the set
    #
    # call-seq:
    #   qualifier_flavors.include? :tosubclass
    #   qualifier_flavors.include? "tosubclass"
    #   qualifier_flavors.include? "ToSubClass"
    #
    # Raises QualifierFlavorError if its not an allowed flavor
    #
    def include? flavor
      @flavors.include?(normalize flavor)
    end
    alias includes? include?
    #
    # returns a string representation in MOF syntax format
    #
    def to_s
      "Flavor(#{@flavors.join(', ')})"
    end
    private
    #
    # Normalize a flavor passed as string or symbol
    # Raises QualifierFlavorError if its not an allowed flavor
    #
    def normalize flavor
      flavor.downcase! if flavor.kind_of? String
      f = flavor.to_sym
      raise QualifierFlavorError.new("#{flavor}") unless FLAVORS.include? f
      f
    end
  end
end
