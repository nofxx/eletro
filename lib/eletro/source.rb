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
        circuits << (part.is_a?(Array) ? part : [part])
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
    # [[50]] => 50 ohms
    #
    def sum_net
      # Memoize
      @sum_net ||= calc_sum_net
    end

    def calc_sum_net(ary=circuits)
      ary.map! do |i|
        if i.respond_to?(:size)
          i = [calc_sum_net(i)] unless i.select { |c| c.is_a?(Array) }.empty?
          i.size > 1 ? serial_sum(i) : i[0]#.value
        else
          i#.value
        end
      end
      ary.size == 1 ? ary[0] : parallel_sum(*ary)
      # out.respond_to?(:value) ? out.value : out
    end

    def parallel_sum(r1, r2, *rest)
      sum = r1 * r2 / (r1 + r2)
      rest.empty? ? sum : parallel_sum(*rest.unshift(sum))
    end

    def serial_sum(ary)
      ary.reduce(0) { |i, c| i + c }
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
