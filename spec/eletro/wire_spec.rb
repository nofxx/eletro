require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Eletro::Wire" do

  let(:w) { Wire.new }

  describe "Value" do

    it "should have width" do
      w.width = 5.mm
      w.width.should eql(5.mm)
    end

    it "should instantiate have i" do
      w.i = 10.mA
      w.i.should eql(10.mA)
    end

    it "should calc width" do
      w.i = 1.A
      w.size.should be_within(0.001).of(0.8)
    end

  end

end
