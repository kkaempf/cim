$: << File.join(File.dirname(__FILE__),"..","lib")

require "test/unit"
require "cim"

class TypeTest < Test::Unit::TestCase
  def test_init
    t = CIM::Type.new :null
    assert t
    assert_equal "null", t.to_s
  end
  def test_raise
    assert_raise TypeError do
      t = CIM::Type.new :foo
    end
  end
end
