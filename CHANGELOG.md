# Changelog

All notable changes to **my_credentials** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),  
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.1.0] - 2025-09-27

### Added
- Initial public release.
- CLI support using Thor (`mycredentials edit --environment production`).
- Encrypted file management using `ActiveSupport::EncryptedFile`.
- Environment-based `.key` and `.yml.enc` files.
- Interactive editor support (`$EDITOR` fallback to `vim`).
- Configurable base path and environment.
- Default example template for new credentials.

---

## [Unreleased]

### Planned
- Support for loading secrets from environment variables fallback.
- Validation or schema checking for credentials structure.
- Encrypted secrets introspection or listing.
