module Qresource
  class Base
    attr_accessor :login, :password, :api_url, :id 

    def get(id) # {{{
      doc = fetch( "#{resource_name.pluralize}/#{id}" )
      result = from_xml(doc)
      return result 
    end # }}}

    def all(params = {}) # {{{
      res = []
      doc = fetch( resource_name.pluralize, params )
      doc.find("//#{resource_name.pluralize}/#{resource_name}").each do |c|
        res << from_xml(c)
      end
      return res
    end # }}}

    def fetch(resource, params = {}) # {{{
      params = {} if params.nil? || params.empty?
      rc = RestClient::Resource.new(api_url, :user => login, :password => password)
      resource = "#{resource}.xml"
      resource = "#{resource}?#{params.to_param}" unless params.empty?
      begin
        response = rc[resource].get
        get_parsed(response)
      rescue
        puts "raised exception in fetch #{$!}"
        puts "response: #{response}"
        get_parsed('exception')
      end
    end # }}}

    def get_parsed(xml_str) # {{{
      xml_str = '<?xml version="1.0" encoding="UTF-8"?><error><message>fetch failed</message></error>' if xml_str == 'exception'
      begin
        p = XML::Parser.new
        p.string = xml_str
        p.parse
      rescue
        puts "raised exception in get_parsed #{$!}"
      end
    end # }}}

    def from_xml(doc) # {{{
      klass = self.class
      new_object = klass.new Hash.from_xml( doc.to_s )[resource_name]
      new_object.api_url = api_url
      new_object.login = login
      new_object.password = password
      return new_object
    end # }}}

    def api_with_login # {{{
      if api_url =~ /^https/
        api_url.gsub('https://',"https://#{login}:#{password}@")
      else
        api_url.gsub('http://',"http://#{login}:#{password}@")
      end
    end # }}}

    def api_link # {{{
      "#{api_with_login}/#{resource}/#{id}"
    end # }}}

    def resource_name # {{{
      self.class.to_s.downcase
    end # }}}

    def self.log(message) # {{{
      return nil if message.nil?
      File.open("log/#{self.class.to_s.downcase}.log",'a') do |f|
        f.write(message+"\n")
      end
    end
    def log(message)
      return nil if message.nil?
      File.open("log/#{self.class.to_s.downcase}.log",'a') do |f|
        f.write(message+"\n")
      end
    end # }}}
  end
end
