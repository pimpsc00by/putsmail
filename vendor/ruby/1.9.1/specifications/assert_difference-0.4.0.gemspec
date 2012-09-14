# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "assert_difference"
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["J. Pablo Fern\u{e1}ndez"]
  s.date = "2012-02-21"
  s.description = "Better assert_difference than Rails by providing a more compact and readable syntax through hashes. For some more information read http://pupeno.com/blog/better-assert-difference."
  s.email = ["pupeno@pupeno.com"]
  s.homepage = "http://github.com/pupeno/assert_difference"
  s.require_paths = ["lib"]
  s.rubyforge_project = "assert_difference"
  s.rubygems_version = "1.8.24"
  s.summary = "An improved assert_difference"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<yard>, [">= 0"])
  end
end
