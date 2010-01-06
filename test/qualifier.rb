$: << ".."

require "test/unit"
require "rbcim"

class QualifierTest < Test::Unit::TestCase
  def test_init
    q = CIM::Qualifier.new
    assert q
    assert q.to_s.empty?
  end
  def test_key
    q = CIM::Qualifier.new :key
    assert q.key?
    assert_equal false, q.in?
    assert q.to_s == "key"
  end
  def test_in
    q = CIM::Qualifier.new :in
    assert q.in?
    assert q.to_s == "in"
  end
  def test_out
    q = CIM::Qualifier.new :out
    assert q.out?
    assert q.to_s == "out"
  end
  def test_write
    q = CIM::Qualifier.new :write
    assert q.write?
    assert q.to_s == "write"
  end
  def test_propagated
    q = CIM::Qualifier.new :propagated
    assert q.propagated?
    assert q.to_s == "propagated"
  end
  def test_raise
    assert_raise RuntimeError do
      CIM::Qualifier.new(:unknown)
    end  
  end
  def test_key_in
    q = CIM::Qualifier.new :key
    assert q.key?
    assert_equal false, q.in?
    q << :in
    assert q.key?
    assert q.in?
  end
  def test_all
    q = CIM::Qualifier.new :key,:in,:out,:write,:propagated
    assert q.to_s == "key,in,out,write,propagated"
  end
end
