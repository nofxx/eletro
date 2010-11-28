module Eletro


  class Transistor < Part

    attr_accessor :i, :name, :ri, :hfe

    def initialize *args
      params, txt = *args.partition { |a| a.is_a?(Hash) }
      @npn = params[0] && params[0][:type] == "pnp" ? false : true
      @name = txt.join
    end

    def w
      v * i
    end

    def npn?
      @npn
    end

    def pnp?
      !@npn
    end


    def self.pnp
      new(:type => "pnp")
    end

    def self.npn
      new
    end

    # Theory of thermal resistance
    # Tj = Ta + Rth(j-a) * P
    #
    # Ta -> Ambient temp
    # Rth(j-a) -> Thermal resistance inbetween Junction and Ambient


  end

end
