require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Eletro::Part" do

  let(:p) { Part.new}

  it "should have pins" do
    p.p0.should eql(:gnd)
  end

  it "should get dynamic" do
    p.p99.should be_nil
  end

  it "should set dynamic" do
    p.p99.should be_nil
    p.p99 = :fu
    p.p99.should eql('fu')
  end


end
