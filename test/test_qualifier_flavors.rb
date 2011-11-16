$: << File.join(File.dirname(__FILE__),"..","lib")

require "test/unit"
require "cim"

class QualifierFlavorsTest < Test::Unit::TestCase
  def test_new
    assert CIM::QualifierFlavors.new
    f = CIM::QualifierFlavors.new(:enableoverride)
    assert f
    assert_equal 1,f.size
    assert f.include? :enableoverride
  end
  def test_raise
    assert_raise CIM::QualifierFlavorError do
      CIM::QualifierFlavors.new(:unknown)
    end
  end
end
