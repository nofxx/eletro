
require "eletro/helpers/color_code"
require "eletro/ohm"
require "eletro/part"
require "eletro/diode"
require "eletro/logic"
require "eletro/source"
require "eletro/resistor"
require "eletro/inductor"
require "eletro/capacitor"
require "eletro/transistor"
require "eletro/ic"

module Eletro

  def self.do_your_thing(args)
    params = args.join
    if params =~ /A|mA/  # need to improve
    else
      puts Resistor.new(params).pretty_output
    end
  end


end
