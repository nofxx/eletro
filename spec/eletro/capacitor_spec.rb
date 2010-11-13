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
      c.value.should be_within(10e-10).of(4.7e-10)
      c.format.should eql("47pF")
    end

    it "should instantiate 102" do
      c = Capacitor.new("102")
      c.value.should be_within(10e-10).of(1.0e-8)
      c.format.should eql("1nF")
    end

    it "should instantiate 472" do
      c = Capacitor.new("472")
      c.value.should be_within(10e-10).of(4.7e-8)
      c.format.should eql("4.7nF")
    end

    it "should instantiate 473" do
      c = Capacitor.new("473")
      c.value.should be_within(10e-10).of(4.7e-7)
      c.format.should eql("47nF")
    end

    it "should instantiate 10nF" do
      c = Capacitor.new("103")
      c.value.should be_within(10e-10).of(1.0e-7)
      c.format.should eql("10nF")
    end

    it "should instantiate 220nF" do
      c = Capacitor.new("224")
      c.value.should be_within(10e-10).of(2.2e-6)
      c.format.should eql("220nF")
    end

  end

end
