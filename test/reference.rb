$: << ".."

require "test/unit"
require "rbcim"

class ReferenceTest < Test::Unit::TestCase
  def test_init
    r = CIM::Reference.new :string, "String", "string", "this is a string", :key
    assert r
    assert r.is_a? CIM::Reference
    assert r.kind_of? CIM::Property
  end
end
