module CIM
    
  class QualifierScopeError < ArgumentError
    def initialize element, msg = nil
      @element = element
      super msg
    end
    def to_s
      "#{@element} is not a valid meta element for scopes"
    end
  end

  class QualifierScope
    META_ELEMENTS = [ :schema, :class, :association, :indication, :qualifier, :property, :reference, :method, :parameter, :any ]
    attr_reader :elements
    def initialize element = :any
      @elements = []
      self << element
    end
    def << element
      e = normalize element
      @elements << e
      self
    end
    def has? element
      @elements.include?(normalize element)
    end
    alias include? has?
    def size
      @elements.size
    end
    def to_s
      "Scope(#{@elements.join(', ')})"
    end
    def to_sym
      @elements.first
    end
  private
    def normalize element
      element.downcase! if element.is_a?(String)
      e = element.to_sym
      raise QualifierScopeError.new(element) unless META_ELEMENTS.include?(e)
      e
    end
  end
end
