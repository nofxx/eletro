# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Eletro::Resistor" do

  let(:rs) { Resistor.new }

  it "should have a fancy instantiate method" do
    200.R.should eql(Resistor.new(220))
  end

  describe "Value" do

    it "should instantiate 220 string ohms" do
      r = Resistor.new("220")
      r.value.should be_within(0.1).of(220.0)
      r.format.should eql("220Ω")
    end

    it "should instantiate 220 integer ohms" do
      r = Resistor.new(220)
      r.value.should be_within(0.1).of(220.0)
      r.format.should eql("220Ω")
    end

    it "should instantiate 100R ohms" do
      r = Resistor.new("100R")
      r.value.should be_within(0.1).of(100.0)
      r.format.should eql("100Ω")
      Resistor.new("100").colors.join.should eql("bkb")
    end

    it "should instantiate 1k ohms" do
      r = Resistor.new("1000.0")
      r.value.should be_within(1000.0).of(0.1)
      r.format.should eql("1kΩ")
      Resistor.new("1k").colors.join.should eql("bkr")
    end

    it "should instantiate 10k ohms" do
      r = Resistor.new("BKO")
      r.value.should be_within(0.1).of(10000)
      r.format.should eql("10kΩ")
      Resistor.new("10k").colors.join.should eql("bko")
    end

    it "should instantiate 100k ohms" do
      r = Resistor.new("BKY")
      r.value.should be_within(0.1).of(100000)
      r.format.should eql("100kΩ")
      Resistor.new("100k").colors.join.should eql("bky")
    end

    it "should instantiate 1m ohms" do
      r = Resistor.new("BKG")
      r.value.should be_within(0.1).of(1000000)
      r.format.should eql("1mΩ")
      Resistor.new("1m").colors.join.should eql("bkg")
    end

    it "should instantiate 10m ohms" do
      r = Resistor.new("BKU")
      r.value.should be_within(0.1).of(10000000)
      r.format.should eql("10mΩ")
      Resistor.new("10m").colors.join.should eql("bku")
    end

    it "should instantiate 1.1k ohms" do
      r = Resistor.new("1100.0")
      r.value.should be_within(0.1).of(1100.1)
      r.format.should eql("1.1kΩ")
    end

    it "should instantiate 1.1k ohms" do
      r = Resistor.new("BBR")
      r.value.should be_within(0.1).of(1100)
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
      r.value.should be_within(0.00001).of(1500000.0)
      r.format.should eql("1.5mΩ")
    end

    it "should get colors for value" do
      r = Resistor.new("1k")
      r.colors.join.should eql("bkr")
    end

    it "should get colors for value" do
      r = Resistor.new("10k")
      r.colors.join.should eql("bko")
    end

    it "should get colors for value" do
      r = Resistor.new("1.1k")
      r.colors.join.should eql("bbr")
    end

    it "should get colors for value" do
      r = Resistor.new("4k7")
      r.colors.join.should eql("yvr")
    end

    it "should get colors for value" do
      r = Resistor.new("220")
      r.colors.join.should eql("rrb")
    end

    it "should get colors for value" do
      r = Resistor.new("110")
      r.colors.join.should eql("bbb")
    end

  end

  describe "Color Code" do

    it "should instantiate 3 chars" do
      r = Resistor.new("BKR")
      r.value.should be_within(0.01).of(1000.0)
      r.format.should eql("1kΩ")
    end

    it "should instantiate 3 chars" do
      r = Resistor.new("BKO")
      r.value.should be_within(0.01).of(10000.0)
      r.format.should eql("10kΩ")
    end

    it "should instantiate 3 chars" do
      r = Resistor.new("YVR")
      r.value.should be_within(0.01).of(4700.0)
      r.format.should eql("4.7kΩ")
    end

    it "should instantiate 3 chars" do
      r = Resistor.new("YVR")
      r.value.should be_within(0.01).of(4700.0)
      r.format.should eql("4.7kΩ")
    end

    it "should instantiate 4 chars" do
      r = Resistor.new("WWRS")
      r.value.should be_within(0.01).of(9900.0)
      r.format.should eql("9.9kΩ ± 10%")
    end

    it "should instantiate 4 chars" do
      r = Resistor.new("BKRL")
      r.value.should be_within(0.01).of(1000.0)
      r.format.should eql("1kΩ ± 5%")
    end

  end


  describe "Term Colors" do

    it "should print nicely" do
      r = Resistor.new("BKR")
      r.value.should be_within(0.01).of(1000.0)
      r.pretty_output.should eql("1kΩ   --\e[0;33mB\e[0m\e[40mK\e[0m\e[41mR\e[0m--")
    end

  end

end
