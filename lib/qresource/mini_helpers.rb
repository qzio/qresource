unless {}.respond_to? :from_xml
  require File.dirname(__FILE__)+'/hash_helper.rb'
end
unless "".respond_to? :blank?
  class String
    def blank?
      return (nil? ||  empty?)
    end
  end
end
unless nil.respond_to? :blank?
  class NilClass
    def blank?
      true
    end
  end
end
