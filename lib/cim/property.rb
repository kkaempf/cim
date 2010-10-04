module CIM
  class Property < CIM::Meta::Feature
    attr_reader :default
    def initialize type, name, qualifiers=nil, default=nil
      @default = default
      unless qualifiers.nil? || qualifiers.kind_of?(Enumerable)
	qualifiers = [ qualifiers ]
      end
      super type, name, qualifiers
    end
  end
end

