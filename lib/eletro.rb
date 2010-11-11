
require "eletro/ohm"
require "eletro/part"
require "eletro/source"
require "eletro/resistor"

module Eletro

  def self.do_your_thing(args)
    params = args.join
    if params =~ /A|mA/  # need to improve
    else
      puts Resistor.new(params).to_s
    end
  end


end
