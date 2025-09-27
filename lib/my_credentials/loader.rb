module MyCredentials
  module Loader
    def self.load(env)
      encrypted_file = ActiveSupport::EncryptedFile.new(
        content_path: MyCredentials.path(env),
        key_path: MyCredentials.key_path(env),
        env_key: "MYC_MASTER_KEY",
        raise_if_missing_key: true
      )

      raw = encrypted_file.read
      raw ? YAML.safe_load(raw, aliases: true, symbolize_names: true) : {}
    end
  end
end
