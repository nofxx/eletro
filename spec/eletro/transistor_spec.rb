# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Eletro::Transistor" do

  let(:t) { Transistor.new }

  it "should have V" do
    t.v = 12
    t.v.should eql(12)
  end

  it "should have I" do
    t.i = 12
    t.i.should eql(12)
  end

  it "should calculate W" do
    t.v= 12
    t.i = 3
    t.w.should eql(36)
  end

  it { t.should be_npn }

  it { t.should_not be_pnp }

  it "should have a name" do
    t2 = Transistor.new("BC547")
    t2.name.should eql("BC547")
  end

  it "should have pnp" do
    t2 = Transistor.new(:type => 'pnp')
    t2.should be_pnp
  end

  it "should have a pnp alternative initialize" do
    t2 = Transistor.pnp
    t2.should be_pnp
  end

  it "should have a npn alternative initialize" do
    t2 = Transistor.npn
    t2.should be_npn
  end

  it "should have an Ri" do
    t.ri = 10
    t.ri.should eql(10)
  end

  it "should have hfe" do

  end



  describe "Thermal Stuff" do

    it "should calculate thermal resistance" do

    end

  end
end
