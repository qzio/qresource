module Qresource
  attr_accessor :_login, :_password, :_api_url, :id 

  def initialize( params = {} ) #{{{
    if !params.nil? && !params.empty?
      params.keys.each {|name| instance_variable_set "@#{name}", params[name] }
    end
  end # }}}

  def get(id) # {{{
    doc = fetch( "#{resource_name.pluralize}/#{id}" )
    from_xml(doc)
  end # }}}

  def all(params = {}) # {{{
    res = []
    doc = fetch( resource_name.pluralize, params )
    doc.find("//#{resource_name.pluralize}/#{resource_name}").each do |c|
      res << from_xml(c)
    end
    res
  end # }}}

  def fetch(resource, params = {}) # {{{
    params = {} if params.nil? || params.empty?
    rc = RestClient::Resource.new(_api_url, :user => _login, :password => _password)
    resource = "#{resource}.xml"
    resource = "#{resource}?#{params.to_param}" unless params.empty?
    begin
      response = rc[resource].get
      get_parsed(response)
    rescue
      # TODO raise an exception here or something atleast!
      nil
    end
  end # }}}

  def get_parsed(xml_str) # {{{
    begin
      p = XML::Parser.new
      p.string = xml_str
      p.parse
    rescue
      # TODO raise exception here!
      nil
    end
  end # }}}

  def from_xml(doc) # {{{
    klass = self.class
    new_object = klass.new Hash.from_xml( doc.to_s )[resource_name]
    new_object._api_url = _api_url
    new_object._login = _login
    new_object._password = _password
    return new_object
  end # }}}

  def api_with_login # {{{
    login_string = (_login.blank?) ? "" : "#{_login}:#{_password}@"
    if _api_url =~ /^https/
      _api_url.gsub('https://',"https://#{login_string}")
    else
      _api_url.gsub('http://',"http://#{login_string}")
    end
  end # }}}

  def api_html_link # {{{
    "#{api_with_login.chomp('/')}/#{resource_name.pluralize}/#{id}"
  end # }}}

  def resource_name # {{{
    self.class.to_s.downcase
  end # }}}

  # these are just for my personal projects :) dont use'em if you dont want to
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
