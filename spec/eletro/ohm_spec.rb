# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Eletro::Ohm" do

  it "should calc ohms law" do
    o = Ohm.new
    o.r = 1000
    o.to_s.should eql("1000 Ω")
  end

  describe "Instance" do
    let(:o) { Ohm.new }

    it "should set and read attribute" do
      o.r.should be_nil
      o.r = 1000
      o.r.should eql(1000)
    end

    it "should accept stick units [current]" do
      o.i.should be_nil
      o.i = 75.mA
      o.i.to_s.should eql("75 mA")
    end

    it "should accept stick units [volts]" do
      o.v.should be_nil
      o.v = 75.V
      o.v.should eql("75 V")
    end

    it "should calc V if I have [I, R]" do
      o.i = 0.048
      o.r = 250
      o.v.should be_within(12.0).of(0.01)
    end

    it "should calc I if I have [V, R]" do
      o.v = 12
      o.r = 250
      o.i.should be_within(0.048).of(0.001)
    end

    it "should calc V if I have [I, R]" do
      o.i = 0.048
      o.r = 250
      o.v.should be_within(12.0).of(0.01)
    end
    # o.r.should eql(1)

  end

end
