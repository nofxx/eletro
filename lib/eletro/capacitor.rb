# -*- coding: utf-8 -*-

module Eletro

  class Capacitor < Part
    attr_accessor :polarized

    include ColorCode

    def initialize(*args)
      parse_color_code(args.join)
    end

    def parse txt
      if m = txt.match(/#{mult.keys.join('|')}/)
        txt.gsub!(/#{m[0]}/, ".")
        m = mult[m[0]]
      else
        st, nd, m = txt.split(//)
        m ||= 0
        m = m.to_i #(10**-(m.to_i))
      end
      num = ("#{st}#{nd}#{'0' * m}").to_f * mult['p']
      num
    end

    def unit
      "F"
    end

    def mult
      { 'n' => 10e-6, 'u' => 10e-9, 'p' => 10e-12 }
    end

    def format
      m = 'p'
      mult.keys.reverse.each do |k|
        m = k if value >= mult[k]
      end
      # v = if value > mult[0]
      #   "%g" % @value
      # elsif value < 1000000
      #   "%gk" % (@value/1000)
      # else
      #   "%gm" % (@value/1000000)
      # end
      out = "%g#{m}#{unit}" %  (value/mult[m]).round
      out += " ± #{@precision}%" if @precision
      out
    end

    def polarized?
      !!@polarized
    end

  end


end
