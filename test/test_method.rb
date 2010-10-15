$: << File.join(File.dirname(__FILE__),"..","lib")

require "test/unit"
require "cim"

class MethodTest < Test::Unit::TestCase
  def test_init
    m = CIM::Method.new :real32, "Foo", CIM::QualifierDeclaration.new(:description, :string, "This is a foo method", :class)
    assert m
    assert_equal "Foo", m.name
    assert m.qualifiers.size > 0
    assert m.qualifiers.include?( :description )
    assert m.qualifiers.include?( :description, :string )
#    assert_equal "This is a foo method", m.description
    assert_equal false, m.to_s.empty?
  end
  def test_nodesc
    m = CIM::Method.new :bool, "Foo"
    assert m
    assert_equal "Foo", m.name
    assert_equal m.type, :bool
#    assert_equal nil, m.description
  end
  def test_raise
    assert_raise TypeError do
      m = CIM::Method.new :foo, "Foo"
    end
  end
end
