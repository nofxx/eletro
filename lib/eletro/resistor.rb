# -*- coding: utf-8 -*-
# eletric 220
# eletric RRO

module Eletro

  class Resistor < Part

    include ColorCode

    def initialize(*args)
      parse_color_code(args.join)
    end

    def parse txt
      if m = txt.match(/#{mult.keys.join('|')}/)
        txt.gsub!(/#{m[0]}/, ".")
        m = mult[m[0]]
      end
      num = txt.to_f
      num *= m if m
      num
    end

    def unit
      "Ω"
    end

    def mult
      { 'k' => 10e2, 'm' => 10e5 }
    end

    def format
      v = if value < 1000
        "%g" % @value
      elsif value < 1000000
        "%gk" % (@value/1000)
      else
        "%gm" % (@value/1000000)
      end
      out = "#{v}#{unit}"
      out += " ± #{@precision}%" if @precision
      out
    end

    def pretty_output
      out = format
      out += "   --"
      @color.each { |c| out +=  COLOR ? rgblize(c) : c }
      out + "--"
    end

  end
end
