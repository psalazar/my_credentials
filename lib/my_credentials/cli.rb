# frozen_string_literal: true

require "thor"
require_relative "editor"

module MyCredentials
  class CLI < Thor
    desc "edit ENV", "Edit credentials for the given environment (e.g., development, staging, production)"
    option :environment, aliases: "-e", desc: "Environment name (optional if provided as argument)"
    def edit(env = nil)
      env ||= options[:environment]
      if env.nil?
        puts "❌ Please specify an environment. Use `edit ENV` or `--environment ENV`."
        exit(1)
      end

      MyCredentials::Editor.edit(env.to_s)
    end
  end
end
