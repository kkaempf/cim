$: << ".."

require "test/unit"
require "rbcim"

class FeatureTest < Test::Unit::TestCase
  def test_init
    f = CIM::Feature.new "Foo", "This is a foo feature", :key, :in
    assert f
    assert_equal "Foo", f.name
    assert_equal "This is a foo feature", f.description
    assert f.key?
    assert f.in?
    assert_equal false, f.to_s.empty?
  end
  def test_nodesc
    f = CIM::Feature.new "Foo"
    assert f
    assert_equal "Foo", f.name
    assert f.description.empty?
  end
  def test_raise
    assert_raise RuntimeError do
      f = CIM::Feature.new "Foo", "", :foo
    end
  end
end
