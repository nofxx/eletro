# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Eletro::Resistor" do

  let(:rs) { Resistor.new }

  describe "Value" do

    it "should instantiate 220 ohms" do
      r = Resistor.new("220")
      r.value.should be_close(220.0, 0.1)
      r.to_s.should eql("220Ω")
    end

    it "should instantiate 100R ohms" do
      r = Resistor.new("100R")
      r.value.should be_close(100.0, 0.1)
      r.to_s.should eql("100Ω")
    end

    it "should instantiate 1k ohms" do
      r = Resistor.new("1k")
      r.value.should be_close(1000.0, 0.1)
      r.to_s.should eql("1kΩ")
    end

    it "should instantiate 1k ohms" do
      r = Resistor.new("1000.0")
      r.value.should be_close(1000.0, 0.1)
      r.to_s.should eql("1kΩ")
    end

    it "should instantiate 3.3k ohms" do
      r = Resistor.new("3.3k")
      r.value.should be_close(3300.0, 0.1)
      r.to_s.should eql("3.3kΩ")
    end

    it "should instantiate 4k7 ohms" do
      r = Resistor.new("4k7")
      r.value.should be_close(4700.0, 0.1)
      r.to_s.should eql("4.7kΩ")
    end

    it "should instantiate 1m5 ohms" do
      r = Resistor.new("1m5")
      r.value.should be_close(15000000.0, 0.01)
      r.to_s.should eql("15mΩ")
    end

  end

  describe "Colors" do

    it "should instantiate 3 chars" do
      r = Resistor.new("BKR")
      r.value.should be_close(1000.0, 0.01)
      r.to_s.should eql("1kΩ")
    end

    it "should instantiate 3 chars" do
      r = Resistor.new("BKO")
      r.value.should be_close(10000.0, 0.01)
      r.to_s.should eql("10kΩ")
    end

    it "should instantiate 3 chars" do
      r = Resistor.new("YVR")
      r.value.should be_close(4700.0, 0.01)
      r.to_s.should eql("4.7kΩ")
    end

    it "should instantiate 3 chars" do
      r = Resistor.new("YVR")
      r.value.should be_close(4700.0, 0.01)
      r.to_s.should eql("4.7kΩ")
    end


    it "should instantiate 4 chars" do
      r = Resistor.new("WWRS")
      r.value.should be_close(9900.0, 0.01)
      r.to_s.should eql("9.9kΩ ± 2%")
    end

  end

end
