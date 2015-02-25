$: << File.join(File.dirname(__FILE__),"..","lib")

require "test/unit"
require "cim"

class InstanceTest < Test::Unit::TestCase
  def setup
    @klass = CIM::Class.new "Dummy_Class"
    @inst = CIM::Instance.new @klass, a: 1, b: 2
  end
  def test_init
    assert @inst
  end
  def test_each
    expect = { a: 1, b: 2 }
    count = 0
    @inst.each do |k,v|
      count += 1
      assert k
      assert_equal expect[k.to_sym], v
    end
    assert_equal expect.size, count
  end
  def test_access
    expect = { "a" => 1, "b" => 2 }
    expect.each do |k,v|
      assert_equal v, @inst[k]
    end
  end
  def test_missing
    expect = { "a" => 1, "b" => 2 }
    expect.each do |k,v|
      assert_equal v, @inst.send(k)
    end
  end
  def xtest_string
    s = @inst.to_s
    assert s
    puts s
    assert s.is_a?(String)
  end
  def test_constructors
    i = CIM::Instance.new @klass, a: 1, b: 2
    assert_equal 1, i.a
    i = CIM::Instance.new @klass, { a: 1, b: 2 }
    assert_equal 1, i.a
    i = CIM::Instance.new @klass, { "a" => 1, "b" => 2 }
    assert_equal 1, i.a
    i = CIM::Instance.new @klass, [ "a", 1, "b", 2 ]
    assert_equal 1, i.a
    i = CIM::Instance.new @klass, [ ["a", 1], ["b", 2] ]
    assert_equal 1, i.a
  end
end
