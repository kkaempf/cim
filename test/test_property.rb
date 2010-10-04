$: << File.join(File.dirname(__FILE__),"..","lib")

require "test/unit"
require "cim"

class PropertyTest < Test::Unit::TestCase
  def test_init
    p = CIM::Property.new :string, "String", CIM::QualifierDeclaration.new(:key, :bool), CIM::QualifierDeclaration.new(:description, :string, "This is a string", :class)
    assert p
    assert p.is_a? CIM::Property
    assert_equal "String", p.name
#    assert p.key?
  end
  def test_name
    p = CIM::Property.new :uint32, "foo"
    assert_equal "foo", p.name
  end
  def test_raise
    assert_raise TypeError do
      p = CIM::Property.new :foo, "foo"
    end
  end
end
