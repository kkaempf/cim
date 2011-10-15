$: << File.join(File.dirname(__FILE__),"..","lib")

require "test/unit"
require "cim"

class QualifierTest < Test::Unit::TestCase
  def test_key
    q = CIM::QualifierDeclaration.new :key, :boolean
    assert q
  end
  def test_raise
    assert_raise RuntimeError do
      CIM::Qualifier.new(:unknown)
    end  
  end
end
