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

      it "should add loads 1k" do
        s = Source.new("12")
        s << Resistor.new("1k")
        s.i.should be_within(0.012).of(0.0001)
      end

      it "should add loads 100 ohm" do
        s = Source.new("12")
        s << Resistor.new("100")
        s.i.should be_within(0.12).of(0.001)
      end

      it "should add two parallel loads" do
        s = Source.new("12")
        s << Resistor.new("2k")
        s << Resistor.new("2k")
        s.sum_net.should be_within(1000.0).of(0.01)
        s.i.should be_within(0.012).of(0.0001)
      end

      it "should add three parallel loads" do
        s = Source.new("12")
        s << Resistor.new("1k")
        s << Resistor.new("1k")
        s << Resistor.new("100")
        s.sum_net.should be_within(83.333).of(0.001)
        s.i.should be_within(0.144).of(0.001)
      end

      it "should add mixed parallel/serial" do
        s = Source.new("12")
        s << Resistor.new("100")
        s << [Resistor.new("100"), Resistor.new("100")]
        s << [Resistor.new("100"), Resistor.new("100")]
        s.circuits.should have(3).items
        s.sum_net.should be_within(50.0).of(0.01)
      end

      it "should add mixed parallel/serial" do
        s = Source.new("12")
        s << Resistor.new("100")
        s << [Resistor.new("100"), Resistor.new("100")]
        s << [Resistor.new("100"), Resistor.new("200")]
        s.circuits.should have(3).items
        s.sum_net.should be_within(54.5454).of(0.01)
      end


      it "should add mixed parallel/serial" do
        s = Source.new("12")
        s << Resistor.new("100")
        s << [Resistor.new("100"), Resistor.new("100")]
        s << [[Resistor.new("100")], [Resistor.new("200")]]
        s.circuits.should have(3).items
        s.sum_net.should be_within(33.333).of(0.001)
      end

      it "should add mixed parallel series with more depth" do
        s = Source.new("12")
        s << Resistor.new("100")
        s << [Resistor.new("100"), Resistor.new("100")]
        s << [Resistor.new("100"), [Resistor.new("100"), Resistor.new("100")]]
        s.circuits.should have(3).items
        s.sum_net.should be_within(33.333).of(0.001)
      end

      # it "should add loads calcs w" do
      #   s = Source.new("12")
      #   s << Resistor.new("40")
      #   s.w.should be_within(3.5999, 0.0001)
      # end

    end

  end

end
