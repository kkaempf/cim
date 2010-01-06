$: << ".."

require "test/unit"
require "rbcim"

class PropertyTest < Test::Unit::TestCase
  def test_init
    p = CIM::Property.new :string, "String", "string", "this is a string", :key
    assert p
    assert p.is_a? CIM::Property
    assert_equal "String", p.to_s
    assert p.key?
  end
  def test_name
    p = CIM::Property.new :uint32, "foo"
    assert_equal "foo", p.display_name
    assert_equal "foo", p.name
    p = CIM::Property.new :uint32, nil, "foo"
    assert_nil p.display_name
    assert_equal "foo", p.name
  end
  def test_raise
    assert_raise RuntimeError do
      p = CIM::Property.new :foo, "foo"
    end
  end
end
