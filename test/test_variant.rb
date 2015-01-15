$: << File.join(File.dirname(__FILE__),"..","lib")

require "test/unit"
require "cim"

class VariantTest < Test::Unit::TestCase
  def test_init
    t = CIM::Variant.new :null, nil
    assert t
    assert_equal "null", t.to_s
  end
  def test_raise
    assert_raise TypeError do
      t = CIM::Variant.new :foo, :bar
    end
  end
  def test_is_a
    assert CIM::Variant.new(:null, nil).is_a? nil
    assert CIM::Variant.new(:boolean, false).is_a? :boolean
    assert CIM::Variant.new(:uint64, 42).is_a? Integer
    assert CIM::Variant.new(:real32, 2.71).is_a? 3.1415
    assert CIM::Variant.new(:string, "").is_a? String
  end
  def test_equality
    assert CIM::Variant.new(:null, nil) == nil
    assert CIM::Variant.new(:boolean, false) == false
    assert CIM::Variant.new(:uint64, 1) == 1
    assert CIM::Variant.new(:real32, 3.1415) == 3.1415
    assert CIM::Variant.new(:string, "foo") == "foo"
  end
end
