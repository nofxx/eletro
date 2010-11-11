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
        m = m.to_i #(10**-(m.to_i))
      end
      ("#{st}#{nd}#{'0' * m}").to_f * mult['p']
    end

    def unit
      "F"
    end

    def mult
      { 'u' => 10e-6, 'n' => 10e-9, 'p' => 10e-12 }
    end

    def format
      m = 'p'
      mult.keys.reverse.each do |k|
        m = k if value >= mult[k]
      end
      out = "%g#{m}#{unit}" %  (value/mult[m]) #.round
      out += " ± #{@precision}%" if @precision
      out
    end

    def polarized?
      !!@polarized
    end

  end


end
