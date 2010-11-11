# -*- coding: utf-8 -*-
# eletric 220
# eletric RRO

module Eletro

  COLOR = true

  class Resistor < Part
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
        @color = params.split(//)
        @value = color2value(@color)
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

    alias :colors :color


    def calc char
      CODE.index(char.downcase.to_sym)
    end

    def color2value chars
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
      st, nd, *rest = value.to_s.split(//)
      out = [CODE[st.to_i], CODE[nd.to_i]]
      index = 1 if rest.size == 3 # ugly... sleepy... fix....
      index ||= (value ** 0.1).round
      out << CODE[index]
      out.map(&:upcase)
    end

    def format
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

    def to_s
      out = format
      out += "   --"
      @color.each do |c|
        out +=  COLOR ? rgblize(c) : c
      end
      out + "--"

    end

    def to_f;      @value;         end
    def to_i;      @value.to_i;    end

    def coerce(other);      [other, @value];    end

    def round
      # todo, table standard values, find nearest...
    end

    def rgblize color
      s = case color.downcase.to_sym
        when :k then  "\e[40m"
        when :b then  "\e[0;33m"
        when :r then  "\e[41m"
        when :g then  "\e[42m"
        when :y then  "\e[1;33m"
        when :o then  "\e[43m"
        when :u then  "\e[44m"
        when :v then  "\e[45m"
        when :w then  "\e[47m"
        when :a then  "\e[31m"
        else ".."
      end
      s += "#{color}\e[0m"
    end

    def bold(txt);      "\e[2m#{txt}\e[0m";    end

  end
end
