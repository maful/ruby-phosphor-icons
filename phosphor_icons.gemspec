# frozen_string_literal: true

require_relative "lib/phosphor_icons/version"

Gem::Specification.new do |spec|
  spec.name = "phosphor_icons"
  spec.version = PhosphorIcons::VERSION
  spec.authors = ["Maful Prayoga"]
  spec.email = ["me@maful.web.id"]
  spec.summary = "Phosphor Icons for Ruby and Rails"
  spec.description = "A package that distributes Phosphor Icons in a gem"
  spec.homepage = "https://github.com/maful/ruby-phosphor-icons"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise "RubyGems 2.0 or newer is required to protect against public gem pushes." unless spec.respond_to?(:metadata)

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.files = Dir["{lib}/**/*"] + ["LICENSE", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency("ox", "~> 2.14")
  spec.add_dependency("railties")
  spec.add_dependency("actionview")
end
