$: << File.join(File.dirname(__FILE__),"..","lib")

require "test/unit"
require "cim"

class NamedElementTest < Test::Unit::TestCase
  def setup
    qboolean = CIM::QualifierDeclaration.new("flag")
    qint     = CIM::QualifierDeclaration.new("value", :uint32)
    qstring  = CIM::QualifierDeclaration.new("description", :string, "This is a description")
    @qualifiers = CIM::QualifierSet.new
    @qualifiers << CIM::Qualifier.new(qboolean)
    @qualifiers << CIM::Qualifier.new(qint)
    @qualifiers << CIM::Qualifier.new(qstring)
  end
  def test_name
    ne = CIM::NamedElement.new "NamedElement"
    assert ne
    assert_equal "NamedElement", ne.name
    assert ne.qualifiers.empty?
    assert_equal String, ne.to_s.class
  end
  def test_qualifiers
    ne = CIM::NamedElement.new "NamedElement", @qualifiers
    assert ne
    assert_equal "NamedElement", ne.name
    assert !ne.qualifiers.empty?
    assert ne.include?(CIM::QualifierDeclaration.new("flag"))
    assert ne.include?("flag")
    ne << CIM::QualifierDeclaration.new("foo")
    assert ne.include?("foo")
  end
end
