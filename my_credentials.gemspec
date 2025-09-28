# frozen_string_literal: true

require_relative "lib/my_credentials/version"

Gem::Specification.new do |spec|
  spec.name = "my_credentials"
  spec.version = MyCredentials::VERSION
  spec.authors = ["Pablo Salazar"]
  spec.email = ["pabloalfredo.salazar@gmail.com"]

  spec.summary = "Secure credential management for Ruby apps with encryption."
  spec.description = "Rails-like encrypted credentials, without Rails. Easily manage secrets per environment in any Ruby project."
  spec.homepage = "https://github.com/psalazar/my_credentials"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      f.start_with?("test/", "spec/", "features/", ".git") || f == File.basename(__FILE__)
    end
  end

  spec.bindir = "exe"
  spec.executables = ["mycredentials"]
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 8.0"
  spec.add_dependency "thor", "~> 1.4"
end
