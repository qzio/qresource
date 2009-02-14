class Hash
  def symbolize_keys!
    each do |k,v| 
      sym = k.respond_to?(:to_sym) ? k.to_sym : k 
      self[sym] = Hash === v ? v.symbolize_keys! : v 
      delete(k) unless k == sym
    end
    self
  end

  def to_param
    str = ''
    each do |k,v|
      str += "#{CGI.escape(k.to_s)}=#{CGI.escape(v)}&"
    end
    str[0..-2]
  end
end
