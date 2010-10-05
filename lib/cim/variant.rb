module CIM
  # A Variant is a typed value
  class Variant
    attr_reader :type, :value
    def initialize type = :null, value = nil
      @type = (type.kind_of? CIM::Type) ? type : CIM::Type.new(type)
      @value = value unless value == :null
    end
    def == v
      $stderr.puts "<#{@type}>#{self} == #{v.class}"
      case v
      when NilClass:   @type == :null && @value.nil?
      when FalseClass: @type == :bool && !@value
      when TrueClass:  @type == :bool && @value
      when String:     @type == :string && @value == v
      when Integer:    @type == :int && @value == v
      when Float:      @type == :real && @value == v
      else
	false
      end			
    end
    def to_s
      if @type == :null
	"null"
      else
	"#{@value.inspect}"
      end
    end
  end
end
