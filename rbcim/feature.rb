module CIM
class Feature < Qualifier
  attr_reader :name, :description
  def initialize name, description = "", *qualifiers
    @name = name
    @description = description
    super *qualifiers
  end
end
end
