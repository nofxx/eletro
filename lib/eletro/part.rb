module Eletro

  class Part
    attr_accessor :value, :unit, :p0, :p1, :v, :i

    def p0
      @p0 ||= :gnd
    end

    def p1
      @p1 ||= :pwd
    end

    def *(other)
      self.class.new(self.value*other)
    end

    def +(other)
      self.class.new(self.value+other)
    end

    def /(other)
      self.class.new(self.value/other)
    end

    def -(other)
      self.class.new(self.value-other)
    end

    def abs
      self.value.abs
    end

    def to_f;      @value;         end
    def to_i;      @value.to_i;    end

    def unit;    end
    def to_s
      "#{@value}#{unit}"
    end


    def coerce(other);      [other, @value];    end

    def round
      # todo, table standard values, find nearest...
    end

    def method_missing(*args)
      txt = args.join
      if txt =~ /p\d+/
        if txt =~ /=/
          var, value = txt.split("=")
          instance_variable_set("@#{var}", value)
          self.class.instance_eval do
            define_method(var, lambda { instance_variable_get("@#{var}") })
          end
        else
          respond_to?(txt) ? send(args.join) : nil
        end
      else
        super
        # raise NoMethodError.new("undefined method `#{args.join}' " +
        # "for #{self.inspect}:#{self.class.name}")
      end

    end

  end


end
