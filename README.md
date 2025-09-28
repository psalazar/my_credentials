# MyCredentials

🔐 **MyCredentials** is a Ruby gem for securely managing sensitive variables, similar to `Rails.credentials`, but completely independent from Rails.

It uses AES-256-GCM encryption via `ActiveSupport::EncryptedFile` to protect API keys, tokens, passwords, and more.

---

## Features

- 🔒 Secure encryption with per-environment keys
- 📄 `.yml.enc` files per environment (`development`, `production`, etc.)
- 🗝️ Automatically generates the `.key` file if missing
- 🧪 Works in any Ruby app (no Rails required)
- 🧰 Hash-style access: `MyCredentials[:api_key]`
- 📝 Interactive editor to modify credentials (`MyCredentials.edit(:env)`)

---

## Installation

Add the gem to your `Gemfile`:

```ruby
gem "my_credentials", path: "../path/to/the/gem"
```

Then run:

```bash
bundle install
```

---

## Basic Usage

### Create credentials

From the terminal or a script:

```bash
EDITOR=vim mycredentials edit --environment staging
```

This command:

- Creates `config/credentials/development.key` if it doesn't exist
- Creates `config/credentials/development.yml.enc` if it doesn't exist
- Opens the decrypted file in your configured editor (`$EDITOR` or `vim`)

---

### Read variables

```ruby
require "my_credentials"

api_key = MyCredentials[:api_key]
mailgun_domain = MyCredentials[:mailgun][:domain]
```

---

## Configuration (optional)

If you need to customize the path or environment:

```ruby
MyCredentials.configure do |config|
  config.secrets_path = "config/credentials"  # Base path for files
  config.env = "production"                   # Environment to use
end
```

If not configured, the defaults are:

- Path: `config/credentials/`
- Environment: determined from `ENV["MYC_ENV"]`, `ENV["RACK_ENV"]`, `ENV["APP_ENV"]`, or `"development"`

---

## Expected File Structure

```
config/credentials/
├── development.yml.enc
├── development.key
├── production.yml.enc
├── production.key
```

The `.key` file should be kept **out of version control**.

---

## Security

### Never commit your key files

Add this to your `.gitignore`:

```
# MyCredentials key files
/config/credentials/*.key
```

You can also use the `MYC_MASTER_KEY` environment variable instead of storing the key on disk.

---

## Example decrypted file

```yaml
api_key: abc123
mailgun:
  api_key: mg-abc987
  domain: example.com
```

---

## Requirements

- Ruby >= 3.1
- `activesupport` >= 8.0

---

## Generate key manually

If you'd rather generate the key manually:

```bash
openssl rand -hex 16 > config/credentials/development.key
```

---

## Inspiration

- `Rails.application.credentials`
- `ActiveSupport::EncryptedFile`
