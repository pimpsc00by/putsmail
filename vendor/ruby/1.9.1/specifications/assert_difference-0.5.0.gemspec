# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "assert_difference"
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["J. Pablo Fern\u{e1}ndez"]
  s.date = "2012-08-06"
  s.description = "Like Rails' assert_difference, but more compact and readable syntax through hashes, testing ranges and improved error reporting."
  s.email = ["pupeno@pupeno.com"]
  s.homepage = "http://pupeno.github.com/assert_difference/"
  s.require_paths = ["lib"]
  s.rubyforge_project = "assert_difference"
  s.rubygems_version = "1.8.24"
  s.summary = "Like Rails' assert_difference, but more powerful"

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
