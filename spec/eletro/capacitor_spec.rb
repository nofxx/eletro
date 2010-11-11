require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Eletro::Capacitor" do

  let(:rs) { Capacitor.new }

  describe "Value" do

    it "should not be polarized" do
      c = Capacitor.new
      c.should_not be_polarized
    end

    it "should instantiate 47" do
      r = Capacitor.new("47")
      r.value.should be_within(220.0).of(0.1)
      r.format.should eql("47pF")
    end

    it "should instantiate 102" do
      r = Capacitor.new("102")
      r.value.should be_within(220.0).of(0.1)
      r.format.should eql("1uF")
    end


  end

end
