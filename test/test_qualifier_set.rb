$: << File.join(File.dirname(__FILE__),"..","lib")

require "test/unit"
require "cim"

class QualifierSetTest < Test::Unit::TestCase
  def setup
    qbool    = CIM::QualifierDeclaration.new("flag")
    qint     = CIM::QualifierDeclaration.new("value", :uint32)
    qstring  = CIM::QualifierDeclaration.new("description", :string, "This is a description")
    @qualifiers = CIM::QualifierSet.new
    @qualifiers << CIM::Qualifier.new(qbool)
    @qualifiers << CIM::Qualifier.new(qint)
    @qualifiers << CIM::Qualifier.new(qstring)
  end
  def test_key
    assert_equal 3, @qualifiers.size
  end
  def test_prefill
    q = CIM::QualifierSet.new "a", :b
    assert 2, q.size
    assert q.include?( "a" )
    assert q.include?( "b", :bool )
  end
  def test_include
    assert @qualifiers.include?( :flag )
    assert @qualifiers.include?( "flag" )
    assert @qualifiers.include?( "flag", :bool )
    assert @qualifiers.include?( "flag", "bool" )
    assert !@qualifiers.include?( "flag", :string )
  end
end
