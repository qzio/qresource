# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{qresource}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["joel hansson"]
  s.date = %q{2009-02-15}
  s.description = %q{FIX (describe your package)}
  s.email = ["joel.hansson@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "README.textile", "Rakefile", "lib/qresource.rb", "lib/qresource/base.rb", "lib/qresource/qlib.rb", "log/qresource.log", "script/console", "script/destroy", "script/generate", "spec/qresource_spec.rb", "spec/qsample.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rspec.rake"]
  s.has_rdoc = true
  s.homepage = %q{FIX (url)}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{qresource}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{FIX (describe your package)}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<extlib>, [">= 0.9"])
      s.add_runtime_dependency(%q<libxml-ruby>, [">= 0.8"])
      s.add_runtime_dependency(%q<rest-client>, [">= 0.9"])
      s.add_development_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<extlib>, [">= 0.9"])
      s.add_dependency(%q<libxml-ruby>, [">= 0.8"])
      s.add_dependency(%q<rest-client>, [">= 0.9"])
      s.add_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<extlib>, [">= 0.9"])
    s.add_dependency(%q<libxml-ruby>, [">= 0.8"])
    s.add_dependency(%q<rest-client>, [">= 0.9"])
    s.add_dependency(%q<newgem>, [">= 1.2.3"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
