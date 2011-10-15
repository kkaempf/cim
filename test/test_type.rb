$: << File.join(File.dirname(__FILE__),"..","lib")

require "test/unit"
require "cim"

class TypeTest < Test::Unit::TestCase
  def test_init
    t = CIM::Type.new :null
    assert t
    assert_equal "null", t.to_s
    assert !t.array?
  end
  def test_raise
    assert_raise TypeError do
      t = CIM::Type.new :foo
    end
  end
  def test_alias
    assert_equal CIM::Type.new(:bool), CIM::Type.new(:boolean)
    assert_equal CIM::Type.new(:datetime), CIM::Type.new(:dateTime)
  end
  def test_normalize
    assert_equal CIM::Type.new(:null), CIM::Type.normalize(:null)
    assert_equal CIM::Type.normalize(:null), CIM::Type.normalize(CIM::Type.new(:null))
  end
end
