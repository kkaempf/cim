$: << ".."

require "test/unit"
require "rbcim"

class TypeTest < Test::Unit::TestCase
  def test_init
    t = CIM::Type.new :nil
    assert t
    assert_equal "nil", t.to_s
  end
  def test_raise
    assert_raise RuntimeError do
      t = CIM::Type.new :foo
    end
  end
end
