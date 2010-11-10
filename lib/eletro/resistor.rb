# -*- coding: utf-8 -*-
# eletric 220
# eletric RRO

module Eletro

  class Resistor
    attr_reader :value, :color

    UNIT = 'Ω'
    MULT = /k|m|g/

    CODE = [:k, :b, :r, :o, :y, :g, :u, :v, :a, :w, :l, :s]
    COLORS = {
      :k => :black,
      :b => :brown,
      :r => :red,
      :o => :orange,
      :y => :yellow,
      :g => :green,
      :u => :blue,
      :v => :violet,
      :a => :gray,
      :w => :white,
      :l => :gold,
      :s => :silver}

    PRECISION = [nil, 1, 2, nil, nil, 0.5, 0.25, 01, 0.05, nil, 5, 10, 20]

    def initialize(*args)
      params = args.join
      if params =~ /\d/
        # m = params.match(/(\d*[,|{k|m|g}|\.]?\d*)\s*(k|m|g)?/)
        # return unless m
        @value = parse(params)
        @color = value2color(@value)
      else
        @value = color2value(params)
        @color = params
      end
    end

    def parse txt
      if mult = txt.match(MULT)
        txt.gsub!(/#{mult[0]}/, ".") #if txt =~ /#{MULT}\d/
        mult = { 'k' => 1000, 'm' => 10000000 }[mult[0]]
      end
      num = txt.to_f
      num *= mult if mult
      num
    end

    def calc char
      CODE.index(char.downcase.to_sym)
    end

    def color2value txt
      chars = txt.split(//) #.each_with_index do |c|
      out = calc(chars[0])
      out = (out.to_s + calc(chars[1]).to_s).to_f
      out *= (10 ** (calc(chars[2])))
      if chars.size > 3
        @precision = PRECISION[calc(chars[3])]
      else
        #out *= (10 ** (calc(chars[2])))
      end
      out
    end

    def value2color value
      val = value.to_i

    end

    def to_s
      v = if value < 1000
        "%g" % @value
      elsif value < 1000000
        "%gk" % (@value/1000)
      else
        "%gm" % (@value/1000000)
      end
      out = "#{v}#{UNIT}"
      out += " ± #{@precision}%" if @precision
      out

    end

  end
end
