module Qresource

  def self.included(base) # {{{
    base.extend ClassMethods
  end # }}}

  module ClassMethods

    def has_many( prop, options = {} ) # {{{
      klass = options[:class_name].to_s.capitalize
      class_eval "def #{prop};puts \"login: \#{_login}\";@#{prop.to_s.singular} ||= #{klass}.new(:_login => _login) ;end; "
      puts "done doing stuffy"
    end # }}}

  end

end

