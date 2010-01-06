module CIM
class Property < Feature
  attr_reader :data_type, :display_name
  def initialize data_type, display_name=nil, name=nil, description=nil, *qualifiers
    raise "Property must have name" unless display_name || name
    @data_type = Type.new data_type
    @display_name = display_name
    super name||display_name, description, *qualifiers
  end
  
  def to_s
    @display_name || @name
  end
end
end
