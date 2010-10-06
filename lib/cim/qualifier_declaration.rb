#
# cim/qualifier_declaration.rb
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  class QualifierDeclaration < NamedElement

    attr_reader :type, :default, :scope, :flavor

    def initialize name, type = :bool, default = false, scope = nil, flavor = nil
      @type = (type.kind_of? Type) ? type : Type.new(type)
      @default = (default.nil? || default.is_a?(CIM::Variant)) ? default : CIM::Variant.new(@type, default)
      @scope = scope
      @flavor = flavor
      super name
    end
      
    def == q
      #	puts "#{@name}:#{@type} == #{q.name}:#{q.type}"
      (@name.downcase == q.name.downcase) &&
        (@type.nil? || q.type.nil? || (@type == q.type))
    end

    def to_sym
      @name.downcase.to_sym
    end

    def to_s
      s = "Qualifier #{@name} : #{@type}"
      s << " = #{@default}" if @default
      s << ",\n\t#{@scope}" if @scope
      s << ",\n\t#{@flavor}" if @flavor
      s
    end
  end
end
