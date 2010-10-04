$: << File.join(File.dirname(__FILE__),"..","lib")

require "test/unit"
require "cim"

class ReferenceTest < Test::Unit::TestCase
  def test_init
    r = CIM::Reference.new :string, "String"
    assert r
    assert r.is_a? CIM::Reference
    assert r.kind_of? CIM::Property
  end
end
