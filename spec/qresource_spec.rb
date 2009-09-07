require File.dirname(__FILE__) + '/spec_helper.rb'

require File.dirname(__FILE__) +'/qsample.rb'

# Time to add your specs!
# http://rspec.info/
describe "Qresource specs" do
  before(:each) do
    @login = 'the_http_username'
    @password = 'the_http_password'
    @api_url = 'http://gottfolk.se/qresource'

    @qsample = Qsample.new(
      :_api_url => @api_url,
      :_login => @login,
      :_password => @password 
    )
  end
  it "should have correct name" do
    @qsample.resource_name.should eql 'qsample'
    @qsample.resource_name_pluralized.should eql 'qsamples'
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
      sample.api_html_link.should ==  "http://#{@login}:#{@password}@gottfolk.se/qresource/qsamples/1"
    end
    it "creating a new object using _parent should work " do
      new_sample = Qsample.new :_parent => @qsample
      new_sample.api_html_link.should ==  "http://#{@login}:#{@password}@gottfolk.se/qresource/qsamples/"
    end

  end
  describe "client without username/pass" do
    it "should also get single resource" do
      qsample = Qsample.new( :_api_url => @api_url)
      sample = qsample.get(1)
      sample.test.should == 'sample string'
      sample.api_html_link.should == @api_url+'/qsamples/1'
    end

    it "should handle resource_name with trailing slash" do
      qsample = Qsample.new( :_api_url => @api_url+'/')
      sample = qsample.get(1)
      sample.test.should == 'sample string'
      sample.api_html_link.should == 'http://gottfolk.se/qresource/qsamples/1'
    end

  end
end
