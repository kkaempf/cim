$: << File.join(File.dirname(__FILE__),"..","lib")

require "test/unit"
require "cim"

class QualifierScopesTest < Test::Unit::TestCase
  def test_new
    assert CIM::QualifierScopes.new
    s = CIM::QualifierScopes.new(:association)
    assert s
    assert_equal 1,s.size
    assert s.include? :association
  end
  def test_raise
    assert_raise CIM::QualifierScopeError do
      CIM::QualifierScopes.new(:unknown)
    end
  end
end
