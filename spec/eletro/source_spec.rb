require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Eletro::Source" do

  let(:ss) { Source.new }

  describe "Instantiate" do

    it "should instantiate 220 v" do
      s = Source.new("220ac")
      s.v.should eql(220)
    end

    it "should instantiate 220 AC" do
      s = Source.new("220ac")
      s.should be_ac
    end

    it "should instantiate 12vdc" do
      s = Source.new("12vdc")
      s.v.should eql(12)
      s.should be_dc
    end

    it "should default to DC" do
      s = Source.new("9")
      s.should be_dc
    end


  end

  describe "Circuits" do

    describe "Loads" do

      it "should add loads" do
        s = Source.new("12")
        s << Resistor.new("1k")
        s.i.should be_close(0.012, 0.0001)
      end

      it "should add loads" do
        s = Source.new("12")
        s << Resistor.new("100")
        s.i.should be_close(0.12, 0.001)
      end

      it "should add loads" do
        s = Source.new("12")
        s << Resistor.new("2k")
        s << Resistor.new("2k")
        s.sum_net.should be_close(1000.0, 0.01)
        s.i.should be_close(0.012, 0.0001)
      end

      it "should add loads" do
        s = Source.new("12")
        s << Resistor.new("1k")
        s << Resistor.new("1k")
        s << Resistor.new("100")
        s.sum_net.should be_close(83.333, 0.001)
        s.i.should be_close(0.144, 0.001)
      end

      # it "should add loads calcs w" do
      #   s = Source.new("12")
      #   s << Resistor.new("40")
      #   s.w.should be_close(3.5999, 0.0001)
      # end

    end

  end

end
