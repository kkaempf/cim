module CIM
class Type
  TYPES = [:nil,:bool,:string,:uint8,:sint8,:uint16,:sint16,:uint32,:sint32,:uint64,:sint64,:real32,:real64,:datetime,:class,:reference,:array]
  attr_reader :type
  def initialize type
    raise "Invalid type" unless TYPES.include? type
    @type = type
  end
  def to_s
    @type.to_s
  end
  def == t
    case t
    when Type: t.type == @type
    when Symbol: t == @type
    else
      false
    end
  end
end
end
