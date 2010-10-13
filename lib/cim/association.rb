#
# cim/association.rb - class CIM::Association
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  #
  # An Association is a Class with the :association Qualifier
  #
  # Only such a class can have Reference properties
  #
  class Association < Class
    #
    # Create Association class
    #
    # call-seq:
    #   Association.new name, qualifiers, alias, superclass, features
    #
    def initialize name, qualifiers, alias_name, superclass, features
      raise "Association needs 'association' qualifier" unless qualifiers.include?(:association, :bool)
      super name, qualifiers, alias_name, superclass, features
    end
    #
    # true if class has associations (association provider)
    #
    def association?
      true
    end
  end
end
