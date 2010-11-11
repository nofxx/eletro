require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Eletro::Capacitor" do

  let(:rs) { Capacitor.new }

  describe "Value" do

    it "should not be polarized" do
      c = Capacitor.new
      c.should_not be_polarized
    end

    it "should instantiate 47" do
      c = Capacitor.new("47")
      c.value.should be_within(220.0).of(0.1)
      c.format.should eql("47pF")
    end

    it "should instantiate 102" do
      c = Capacitor.new("102")
      c.value.should be_within(220.0).of(0.1)
      c.format.should eql("1nF")
    end

    it "should instantiate 472" do
      c = Capacitor.new("472")
      c.value.should be_within(220.0).of(0.1)
      c.format.should eql("4.7nF")
    end

    it "should instantiate 473" do
      c = Capacitor.new("473")
      c.value.should be_within(220.0).of(0.1)
      c.format.should eql("47nF")
    end

  end

end
