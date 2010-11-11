module Eletro

  class Source < Part

    attr_accessor :hz, :v, :circuits


    def initialize(*args)
      params = args.join
      @v = params.match(/(\d*)/)[1].to_i
      @hz = params =~ /ac|AC/ ? 60 : 0
      @circuits = []
    end



    def <<(part, circuit=nil)
      if circuit

      else
        circuits << [part]
      end
    end

    def i
      @v / sum_net.to_f
    end

    def w
      @v * i
    end

    #
    # Logic:
    #
    # Resistor on an array are in series, sum.  [100, 100] => [200]
    # Arrays in arrays are parallel connections. [[100], [100]] => [50]
    #
    # Mixed example (rounded):
    #
    # [[100], [100, 100], [100, 100]]
    # [[100], [200], [200]]
    # [[66], [200]]
    # [[49]] => 49 ohms
    #
    def sum_net
      @sum_net ||= calc_sum_net
    end

    def calc_sum_net(ary=circuits)
      total = 0
      children = ary.select do |a|
        a.is_a?(Array) && !a.select { |c| c.is_a?(Array) }.empty?
      end
      if children.empty?
        # Sum series
        ary.map! do |a|
          a.size > 1 ? a.reduce(0) { |i, c| i + c } : a[0].value
        end
        if ary.size == 1
          ary[0]
        else
          recurse_sum(*ary)
        end
      else
        children.map { |c| calc_sum_net(c) }
      end
    end

    def recurse_sum(r1, r2, *rest)
      if rest.empty?
        r1 * r2 / (r1 + r2)
      else
        v = r1 * r2 / (r1 + r2)
        recurse_sum(*rest.unshift(v))
      end
    end

    #just for fun
    def acdc
      dc? || (@v /= 2)
    end

    def dc?
      @hz.zero?
    end

    def ac?
      !dc?
    end
  end
end
