#$:.unshift(File.dirname(__FILE__)) unless
#  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

#deps:
require 'xml/libxml'
require 'extlib'
require 'rest_client'

module Qresource
  VERSION = '0.0.2'
end
require File.dirname(__FILE__)+'/qresource/qlib.rb'
require File.dirname(__FILE__)+'/qresource/qresource.rb'
require File.dirname(__FILE__)+'/qresource/associations.rb'
