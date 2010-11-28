module Eletro


  class Wire < Part
    MULT = { :mil => 2.54e-3, :mm => 0.1, :um => 1e-4 }
    TEMP = 25
    RHO = 1.7e-6
    ALPHA = 3.9e-3 # //ohm/ohm/C

    LEN = 1
    TEMP_RISE = 10
    THICKNESS = 0.1


    IRISE = {
      :internal => { :k => 0.048, :b => 0.44, :c => 0.725 },
      :external => { :k => 0.024, :b => 0.44, :c => 0.725 }
      # return Math.pow((current/(k*Math.pow(rise,b))),1/c)

    }

    attr_accessor :width, :thickness, :length

    def spacing
      case v
      when 0..100 then [0.005, 0.004]
      when 101..300 then [0.015, 0.008]
      when 301..500 then [0.030, 0.010]
      else
        0.030 * ( v / 500)
      end
    end

    def area(place)
      @area = (i / IRISE[place][:k] * (TEMP_RISE ** IRISE[place][:b])) ** (1/IRISE[place][:c])
    end

    def tk
      @tk || THICKNESS
    end

    def calc(pos = :external)
      area = area(pos) #, @temp_rise || TEMP_RISE) #  //mils^2
      area = area * 2.54 * 2.54 / 1e6 # //mil^2 to cm^2
      wi = area / tk
      wi = wi / MULT[@mult || :mm]
      tval = 1 * (@temp || TEMP) + 1 * TEMP_RISE
      ri = (RHO * LEN / area) * (1 + ALPHA * (tval-25))
      vi = ri * i
      pi = i * i * ri

      # ae = area
      # ae = ae * 2.54 * 2.54 / 1e6 #  //mil^2 to cm^2
      # we = ae/tk # //cm
      # we = we/document.getElementById("twSelect3").value # //user units
      # re = (rho*len/ae)*(1+alpha*(tval-25))
      # ve = re*i
      # pe = i*i*re

    end

    def size
      calc
    end

  end

end
