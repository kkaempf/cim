#
# cim/reference.rb - class CIM::Reference
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  #
  # Reference is a pointer (reference) to a Class
  #
  # A Reference is a special type of Property reserved for
  # use in Associations
  #
  class Reference < CIM::Property
    #
    # Identifies a Property as a Reference
    #
    def reference?
      true
    end
  end
end
