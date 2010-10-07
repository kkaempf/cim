#
# cim/indication.rb
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  class Indication < Class
    # true if class has indications (indication provider)
    def indication?
      true
    end
  end
end