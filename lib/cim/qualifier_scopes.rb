#
# cim/qualifier_scopes.rb - class CIM::QualifierScopes, class CIM::QualifierScopesError
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
    
  class QualifierScopesError < ArgumentError
    #
    # Raised if wrong Scope passed
    #
    def initialize element, msg = nil
      @element = element
      super msg
    end
    def to_s
      "#{@element} is not a valid meta element for scopes"
    end
  end

  class QualifierScopes
    META_ELEMENTS = [ :schema, :class, :association, :indication, :qualifier, :property, :reference, :method, :parameter, :any ]
    attr_reader :elements
    #
    # call-seq:
    #   QualifierScopes.new => qualifier_scopes
    #   QualifierScopes.new(:association) => qualifier_scopes
    #   QualifierScopes.new("association") => qualifier_scopes
    #   QualifierScopes.new("Association") => qualifier_scopes
    #
    # raises QualifierScopesError
    #
    def initialize element = :any
      @elements = []
      self << element
    end
    #
    # call-seq:
    #   qualifier_scopes << :association
    #   qualifier_scopes << "association"
    #   qualifier_scopes << "Association"
    #
    # raises QualifierScopesError
    #
    def << element
      @elements << (normalize element)
      self
    end
    #
    # call-seq:
    #   qualifier_scopes.has? :association
    #   qualifier_scopes.has? "association"
    #   qualifier_scopes.has? "Association"
    #
    # raises QualifierScopesError
    #
    def include? element
      @elements.include?(normalize element)
    end
    alias includes? include?
    #
    # Number of scopes
    #
    def size
      @elements.size
    end
    #
    # returns a string representation in MOF syntax format
    #
    def to_s
      "Scope(#{@elements.join(', ')})"
    end
  private
    def normalize element
      element.downcase! if element.is_a?(String)
      e = element.to_sym
      raise QualifierScopesError.new(element) unless META_ELEMENTS.include?(e)
      e
    end
  end
end
