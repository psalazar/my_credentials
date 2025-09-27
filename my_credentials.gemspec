# frozen_string_literal: true

require_relative "lib/my_credentials/version"

Gem::Specification.new do |spec|
  spec.name = "my_credentials"
  spec.version = MyCredentials::VERSION
  spec.authors = ["psalazar"]
  spec.email = ["pabloalfredo.salazar@gmail.com"]

  spec.summary = "Module for secure credential handling in Ruby with encryption."
  spec.description = "Similar to Rails.credentials, but decoupled and configurable."
  spec.homepage = "https://github.com/psalazar/my_credentials"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 8.0"
end
