module CIM
  class Method < CIM::Meta::Feature
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
    def to_s
      p = @parameters.join(", ") if @parameters
      "#{super}(#{p})"
    end
  end
end
