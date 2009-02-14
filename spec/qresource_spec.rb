require File.dirname(__FILE__) + '/spec_helper.rb'

require File.dirname(__FILE__) +'/qsample.rb'

# Time to add your specs!
# http://rspec.info/
describe "Qresource specs" do
  before(:each) do
    @qsample = Qsample.new(
      :api_url => 'http://gottfolk.se/qresource',
      :login => 'login',
      :password => 'password'
    )
  end
  describe "get list" do
    it "should get qsample list" do
      samples = @qsample.all
      samples.should_not be_nil
      first_sample = samples.first
      first_sample.test.should == 'sample string'
      samples[1].test.should == 'second sample string'
    end
  end

  describe "get single resource" do
    it "should get a qsample object" do
      sample = @qsample.get(1)
      sample.test.should == 'sample string'
    end
  end
end