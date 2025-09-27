# lib/my_credentials.rb
require "active_support/encrypted_file"
require "yaml"

require_relative "my_credentials/version"
require_relative "my_credentials/loader"
require_relative "my_credentials/editor"

module MyCredentials
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def env
      configuration.env || ENV["MYC_ENV"] || ENV["RACK_ENV"] || ENV["APP_ENV"] || "development"
    end

    def for(target_env = env)
      Loader.load(target_env)
    end

    def [](key)
      credentials = self.for(env)
      credentials[key.to_s] || credentials[key.to_sym]
    end

    def edit(target_env = env)
      Editor.edit(target_env)
    end

    def available_envs
      Dir.glob(File.join(configuration.secrets_path, "*.yml.enc")).map do |f|
        File.basename(f, ".yml.enc").to_sym
      end
    end

    def path(env)
      File.join(configuration.secrets_path, "#{env}.yml.enc")
    end

    def key_path(env)
      File.join(configuration.secrets_path, "#{env}.key")
    end
  end

  class Configuration
    attr_accessor :secrets_path, :env

    def initialize
      @secrets_path = "config/credentials"
      @env = nil
    end
  end
end
