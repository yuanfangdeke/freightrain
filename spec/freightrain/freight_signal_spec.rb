
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FreightSignal do
  
  before :each do
    @signal = FreightSignal.new
  end

  describe "connect" do

    it "should keep only last proc connected" do
      @signal.connect lambda { return :first }
      @signal.connect lambda { return :second }
      @signal.instance_variable_get(:@proc).call.should == :second
    end

  end

  describe "fire" do

    it "should fail silently if no proc is registered" do
      @signal.fire
    end

    it "should call proc if proc is not nil" do
      @signal.connect lambda{ @called = true }
      @signal.fire
      @called.should == true
    end

    it "should call proc with right arguments if arguments passed" do
      @signal.connect lambda {|param_one, param_two| @result = param_one + param_two}
      @signal.fire(4,2)
      @result.should == 6
    end

#    it "should call proc passing block if block passed"

  end

end

