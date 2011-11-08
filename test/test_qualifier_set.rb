$: << File.join(File.dirname(__FILE__),"..","lib")

require "test/unit"
require "cim"

class QualifierSetTest < Test::Unit::TestCase
  def setup
    qboolean = CIM::QualifierDeclaration.new("flag")
    qint     = CIM::QualifierDeclaration.new("value", :uint32)
    qstring  = CIM::QualifierDeclaration.new("description", :string, "This is a description")
    @qualifiers = CIM::QualifierSet.new
    @qualifiers << CIM::Qualifier.new(qboolean)
    @qualifiers << CIM::Qualifier.new(qint)
    @qualifiers << CIM::Qualifier.new(qstring)
  end
  def test_key
    assert_equal 3, @qualifiers.size
  end
  def test_prefill
    q = CIM::QualifierSet.new "a", :b
    assert_equal 2, q.size
    assert q.include?( "a" )
    assert q.include?( "b", :boolean )
  end
  def test_include
    assert @qualifiers.include?( :flag )
    assert @qualifiers.include?( "flag" )
    assert @qualifiers.include?( "flag", :boolean )
    assert @qualifiers.include?( "flag", "boolean" )
    assert !@qualifiers.include?( "flag", :string )
  end
  def test_access
    assert @qualifiers[:flag]
    assert @qualifiers["flag"]
    assert @qualifiers["flag", :boolean]
    assert @qualifiers["flag", "boolean"]
    assert !@qualifiers["flag", :string]
  end
end
