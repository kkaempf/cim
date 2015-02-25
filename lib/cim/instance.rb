#
# cim/instance.rb - class CIM::Instance
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  #
  # Instance represents a static Class object (defined in a MOF file)
  #
  # --
  # - to be implemented
  #
  class Instance
    attr_reader :klass
    #
    # Create new instance of klass with properties
    # klass: CIM::Class
    # properties: Hash or Array of key,value pairs
    #
    # call-seq:
    #   CIM::Instance.new klass, a: 1, b: 2
    #   CIM::Instance.new klass, {a: 1, b: 2 }
    #   CIM::Instance.new klass, {"a" => 1, "b" => 2 }
    #   CIM::Instance.new klass, ["a", 1, "b", 2 ]
    #   CIM::Instance.new klass, [ ["a", 1], ["b", 2] ]
    #
    def initialize klass, properties
      @klass = klass
      unless properties.is_a?(Hash)
        properties = Hash[*properties.flatten]
      end
      # http://stackoverflow.com/questions/812541/ruby-change-each-value-in-a-hash-with-something-like-collect-for-arrays
      @properties = properties.inject({}) { |h, (k,v)| h[k.to_s] = v; h }
    end
    #
    # each - iterate over properties
    #
    def each
      @properties.each do |k,v|
        yield [k,v]
      end
    end
    #
    # [] - access property by name
    #
    def [] name
      @properties[name.to_s]
    end
    #
    # to_s - string representation (similar to CIM ObjectPath)
    #
    def to_s
      s = @klass.name
      first = true
      @properties.each do |k,v|
        s << ((first) ? "." : ",")
        first = false
        s << k
        s << "="
        s << v.inspect
      end
      s
    end
    #
    # Allow for instance#property_name
    #
    def method_missing name, *args
      name = name.to_s
      return @properties[name] if @properties.has_key?(name)
      raise "No such property in instance: #{name.inspect}"
    end
  end
end
