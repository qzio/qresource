RestClient.log = File.dirname(__FILE__)+'/../log/qresource.log'
class Qsample < Qresource::Base
  attr_accessor :test
=begin
  def initialize( *args ) # {{{
    p = args.first
    p.symbolize_keys!
    unless p[:login].blank?
      @login = p[:login]
      @password = p[:password]
      @api_url = p[:api_url]
      return
    end 
    @test = p[:test]
  end # }}}
=end

end
