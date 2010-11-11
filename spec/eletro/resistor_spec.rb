# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Eletro::Resistor" do

  let(:rs) { Resistor.new }

  describe "Value" do

    it "should instantiate 220 ohms" do
      r = Resistor.new("220")
      r.value.should be_within(220.0).of(0.1)
      r.format.should eql("220Ω")
    end

    it "should instantiate 100R ohms" do
      r = Resistor.new("100R")
      r.value.should be_within(100.0).of(0.1)
      r.format.should eql("100Ω")
    end

    it "should instantiate 1k ohms" do
      r = Resistor.new("1k")
      r.value.should be_within(1000.0).of(0.1)
      r.format.should eql("1kΩ")
    end

    it "should instantiate 1k ohms" do
      r = Resistor.new("1000.0")
      r.value.should be_within(1000.0).of(0.1)
      r.format.should eql("1kΩ")
    end

    it "should instantiate 1k ohms" do
      r = Resistor.new("1100.0")
      r.value.should be_within(1100.0).of(0.1)
      r.format.should eql("1.1kΩ")
    end

    it "should instantiate 1k ohms" do
      r = Resistor.new("BBR")
      r.value.should be_within(1100.0).of(0.1)
      r.format.should eql("1.1kΩ")
    end

    it "should instantiate 3.3k ohms" do
      r = Resistor.new("3.3k")
      r.value.should be_within(3300.0).of(0.1)
      r.format.should eql("3.3kΩ")
    end

    it "should instantiate 4k7 ohms" do
      r = Resistor.new("4k7")
      r.value.should be_within(4700.0).of(0.1)
      r.format.should eql("4.7kΩ")
    end

    it "should instantiate 1m5 ohms" do
      r = Resistor.new("1m5")
      r.value.should be_within(15000000.0).of(0.1)
      r.format.should eql("1.5mΩ")
    end

    it "should get colors for value" do
      r = Resistor.new("1k")
      r.colors.join.should eql("BKR")
    end

    it "should get colors for value" do
      r = Resistor.new("10k")
      r.colors.join.should eql("BKO")
    end

    it "should get colors for value" do
      r = Resistor.new("1.1k")
      r.colors.join.should eql("BBR")
    end

    it "should get colors for value" do
      r = Resistor.new("4k7")
      r.colors.join.should eql("YVR")
    end

    it "should get colors for value" do
      r = Resistor.new("220")
      r.colors.join.should eql("RRB")
    end

    it "should get colors for value" do
      r = Resistor.new("110")
      r.colors.join.should eql("BBB")
    end

  end

  describe "Colors" do

    it "should instantiate 3 chars" do
      r = Resistor.new("BKR")
      r.value.should be_within(1000.0).of(0.01)
      r.format.should eql("1kΩ")
    end

    it "should instantiate 3 chars" do
      r = Resistor.new("BKO")
      r.value.should be_within(10000.0).of(0.01)
      r.format.should eql("10kΩ")
    end

    it "should instantiate 3 chars" do
      r = Resistor.new("YVR")
      r.value.should be_within(4700.0).of(0.01)
      r.format.should eql("4.7kΩ")
    end

    it "should instantiate 3 chars" do
      r = Resistor.new("YVR")
      r.value.should be_within(4700.0).of(0.01)
      r.format.should eql("4.7kΩ")
    end

    it "should instantiate 4 chars" do
      r = Resistor.new("WWRS")
      r.value.should be_within(9900.0).of(0.01)
      r.format.should eql("9.9kΩ ± 10%")
    end

    it "should instantiate 4 chars" do
      r = Resistor.new("BKRL")
      r.value.should be_within(1000.0).of(0.01)
      r.format.should eql("1kΩ ± 5%")
    end

  end


  describe "Colors" do

    it "should print nicely" do
      r = Resistor.new("BKR")
      r.value.should be_within(1000.0).of(0.01)
      r.pretty_output.should eql("1kΩ   --\e[0;33mB\e[0m\e[40mK\e[0m\e[41mR\e[0m--")
    end

  end

end
