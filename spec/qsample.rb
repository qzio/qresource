#require File.dirname(__FILE__)+'/../lib/qresource.rb'
RestClient.log = File.dirname(__FILE__)+'/../log/qresource.log'
class Qsample
  include Qresource
  attr_accessor :test
end
