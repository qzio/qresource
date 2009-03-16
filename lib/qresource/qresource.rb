module Qresource
  attr_accessor :_login, :_password, :_api_url, :id 

  def initialize( params = {} ) #{{{
    if !params[:_parent].nil? and params[:_parent].respond_to? '_login'
      @_login = params[:_parent]._login
      @_password = params[:_parent]._password
      @_api_url = params[:_parent]._api_url
      params[:_parent] = nil
    end

    if !params.nil? && !params.empty?
      params.keys.each {|name| instance_variable_set "@#{name}", params[name] }
    end
  end # }}}

  def get(id) # {{{
    doc = fetch( "/#{resource_name.pluralize}/#{id}" )
    from_xml(doc)
  end # }}}

  def all(params = {}) # {{{
    res = []
    doc = fetch( "/#{resource_name.pluralize}", params )
    doc.find("//#{resource_name.pluralize}/#{resource_name}").each do |c|
      res << from_xml(c)
    end
    res
  end # }}}

  def fetch(resource, params = {}) # {{{
    raise Qexception, "no api_url(#{@_api_url})" if _api_url.blank?
    params = {} if params.nil? || params.empty?
    rc = RestClient::Resource.new(_api_url, :user => _login, :password => _password)
    resource = "#{resource}.xml"
    resource = "#{resource}?#{params.to_param}" unless params.empty?
    begin
      response = rc[resource].get
    rescue
      # TODO raise an exception here or something atleast!
      raise Qexception, "response failed #{$!} when fetching #{resource}"
    end
    get_parser(response)
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

  # these are just aliases for the singleton methods
  def logger # {{{
    klass = self.class
    klass.logger
  end # }}}

  def get_parser(xml_str) # {{{
    klass = self.class
    klass.get_parser(xml_str)
  end # }}}

  def self.included(base) # {{{
    base.extend ClassMethods
  end # }}}

  module ClassMethods
    @@logger = Logger.new("log/#{self.to_s.downcase}.log")
    def get_parser( xml_str ) # {{{
      begin
        p = XML::Parser.new
        p.string = xml_str
        p.parse
      rescue
        # TODO raise exception here!
        raise Qexception, "unable to parse xml_str #{$!}"
      end
    end # }}}

    def logger # {{{
      return @@logger unless @@logger.nil?
      @@logger = Logger.new("log/#{self.to_s.downcase}.log")
      @@logger.level = Logger::INFO
      return @@logger
    end  # }}} 

  end

end
