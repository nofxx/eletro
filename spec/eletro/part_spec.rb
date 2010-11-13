require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Eletro::Part" do

  let(:part) { Part.new}

  it "should have pins" do
    part.p0.should eql(:gnd)
  end

  it "should get dynamic" do
    part.p99.should be_nil
  end

  it "should set dynamic" do
    part.p99.should be_nil
    part.p99 = :fu
    part.p99.should eql('fu')
  end

  it "should return NoMethodErrors" do
    lambda { part.blablabla }.should raise_error
  end

end
