module Eletro

  class Part
    attr_writer :p0, :p1

    def p0
      @p0 ||= :gnd
    end

    def p1
      @p1 ||= :pwd
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
        raise NoMethodError.new("undefined method `#{args.join}' " +
        "for #{self.inspect}:#{self.class.name}")
      end

    end

  end

end


def fatorial(n, t=nil)
  t ||= n

  if n == 1
    puts "Cabou #{t}"
  else
    fatorial(n-1, t * (n-1))
  end
end




def conta(n)
  puts "Numero eh #{n}"
  conta(n-1) if n > 0
end
