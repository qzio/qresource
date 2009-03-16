#$:.unshift(File.dirname(__FILE__)) unless
#  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

#deps:
require 'rubygems'
require 'xml/libxml'
require 'extlib'
require 'rest_client'
require 'logger'

module Qresource
  VERSION = '0.0.3'
end
require File.dirname(__FILE__)+'/qresource/qlib.rb'
require File.dirname(__FILE__)+'/qresource/qresource.rb'
require File.dirname(__FILE__)+'/qresource/qexception.rb'
#require File.dirname(__FILE__)+'/qresource/associations.rb'
