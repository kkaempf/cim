$: << ".."

require "test/unit"
require "rbcim"

class MethodTest < Test::Unit::TestCase
  def test_init
    m = CIM::Method.new :real32, "Foo", "This is a foo method"
    assert m
    assert_equal "Foo", m.name
    assert_equal "This is a foo method", m.description
    assert_equal false, m.to_s.empty?
  end
  def test_nodesc
    m = CIM::Method.new :bool, "Foo"
    assert m
    assert_equal "Foo", m.name
    assert_equal m.type, :bool
    assert_equal nil, m.description
  end
  def test_raise
    assert_raise RuntimeError do
      m = CIM::Method.new :foo, "Foo"
    end
  end
end
