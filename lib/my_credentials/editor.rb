require "tempfile"
require "securerandom"
require "fileutils"

module MyCredentials
  module Editor
    DEFAULT_EDITOR = "vim".freeze

    def self.edit(env)
      ensure_key_exists(env)
      ensure_encrypted_file_exists(env)

      encrypted_file = encrypted_file_for(env)

      Tempfile.create(%w(credentials .yml)) do |tmp|
        tmp.write(encrypted_file.read || "")
        tmp.flush

        editor = ENV["EDITOR"] || DEFAULT_EDITOR
        puts "[my_credentials] 📝 No $EDITOR set. Using default: #{DEFAULT_EDITOR}" unless ENV["EDITOR"]
        puts "Editing #{encrypted_file.content_path}..."
        system("#{editor} #{tmp.path}")

        new_content = File.read(tmp.path)
        encrypted_file.write(new_content)
        puts "File encrypted and saved."
      end
    end

    private_class_method def self.ensure_key_exists(env)
      path = MyCredentials.key_path(env)
      return if File.exist?(path)

      FileUtils.mkdir_p(File.dirname(path))
      key = SecureRandom.hex(16)
      File.write(path, key)
      puts "[my_credentials] 🔑 Key generated in #{path}"
      puts "[my_credentials] 📌 Added 128-bit key (AES-128-GCM)"
      if env == "production"
        puts "[my_credentials] ⚠️ For security, remember to add config/credentials/production.key to your .gitignore"
      end
    end

    private_class_method def self.ensure_encrypted_file_exists(env)
      path = MyCredentials.path(env)
      return if File.exist?(path)

      FileUtils.mkdir_p(File.dirname(path))
      encrypted_file_for(env).write(default_template)
      puts "[my_credentials] 📄 Encrypted file generated in #{path}"
    end

    private_class_method def self.encrypted_file_for(env)
      ActiveSupport::EncryptedFile.new(
        content_path: MyCredentials.path(env),
        key_path: MyCredentials.key_path(env),
        env_key: "MYC_MASTER_KEY",
        raise_if_missing_key: true
      )
    end

    private_class_method def self.default_template
      <<~YAML
      # Example credentials file
      # Use this file to store sensitive settings like API keys, passwords, etc.
      #
      # api_key: your-api-key-here
      # postgres:
      #   db_password: your-database-password-here
    YAML
    end
  end
end
