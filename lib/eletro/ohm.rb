# -*- coding: utf-8 -*-
require 'stick/units'
require 'bigdecimal'

module Eletro
  class Ohm
    attr_accessor :v, :r, :i, :p
    VALUES = [:v, :r, :i]

    def initialize(*args)
      args.each { |a| puts a.inspect }
    end


    # def r
    #   calc(:r) || @r = v / i
    # end

    def v
      @v || (calc(:v) ? @v = i * r.to_f : nil)
    end

    def i
      @i || (calc(:i) ? @i = v / r.to_f : nil)
    end

    def r=(r);      calc(:r, r);    end
    def v=(v);      calc(:v, v);    end
    def i=(i);      calc(:i, i);    end

    def calc(v, data=nil)
      if data
        # instance_variable_set("@#{v}", BigDecimal.new(data.to_s))
       # puts data.class
        instance_variable_set("@#{v}", data)
      else
    #     val = instance_variable_get("@#{v}")
    #     return val if val

      (VALUES - [v]).select { |v| instance_variable_get("@#{v}").nil? }.empty?

    #       raise "Can't call dunno #{v}" unless instance_variable_get("@#{v}")
    #     end
      end
    end

    def to_s
      o = ""
      VALUES.each do |v|
        if val = send(v)
          o += "#{val} " + { :r => "Ω", :i => "A", :v => "V"}[v]
        end
      end
      o
    end
  end
end
