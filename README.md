# MyCredentials

🔐 **MyCredentials** es una gema para manejar variables sensibles de forma segura en aplicaciones Ruby, similar a `Rails.credentials` pero independiente de Rails.

Utiliza cifrado AES-256-GCM mediante `ActiveSupport::EncryptedFile` para proteger claves API, tokens, contraseñas y más.

---

## Características

- 🔒 Cifrado seguro con claves por entorno
- 📄 Archivos `.yml.enc` por entorno (`development`, `production`, etc.)
- 🗝️ Genera automáticamente la clave `.key` si no existe
- 🧪 Compatible con cualquier aplicación Ruby (no requiere Rails)
- 🧰 Acceso tipo hash: `MyCredentials[:api_key]`
- 📝 Editor interactivo para modificar credenciales (`MyCredentials.edit(:env)`)

---

## Instalación

Agrega la gema a tu `Gemfile`:

```ruby
gem "my_credentials", path: "../ruta/a/la/gema"
```

Luego ejecuta:

```bash
bundle install
```

---

## Uso básico

### Crear las credenciales

Desde consola o script:

```bash
EDITOR=vim mycredentials edit --environment staging
```

Este comando:

- Crea `config/credentials/development.key` si no existe
- Crea `config/credentials/development.yml.enc` si no existe
- Abre el archivo desencriptado en el editor configurado (`$EDITOR` o `vim`)

---

### Leer variables

```ruby
require "my_credentials"

api_key = MyCredentials[:api_key]
mailgun_domain = MyCredentials[:mailgun][:domain]
```

---

## Configuración (opcional)

Si necesitas personalizar la ruta o el entorno:

```ruby
MyCredentials.configure do |config|
  config.secrets_path = "config/credentials"  # Ruta base para archivos
  config.env = "production"               # Entorno a usar
end
```

Si no configuras nada, se usan por defecto:

- Ruta: `config/credentials/`
- Entorno: detectado desde `ENV["MYC_ENV"]`, `ENV["RACK_ENV"]`, `ENV["APP_ENV"]` o `"development"`

---

## Estructura esperada

```
config/credentials/
├── development.yml.enc
├── development.key
├── production.yml.enc
├── production.key
```

El archivo `.key` debe mantenerse **fuera del control de versiones**.

---

## Seguridad

### No subas tus claves al repositorio

Agrega a tu `.gitignore`:

```
# Claves de my_credentials
/config/credentials/*.key
```

También puedes usar la variable de entorno `MYC_MASTER_KEY` para evitar almacenar la clave en disco.

---

## Ejemplo de archivo desencriptado

```yaml
api_key: abc123
mailgun:
  api_key: mg-abc987
  domain: example.com
```

---

## Requisitos

- Ruby >= 3.1
- `activesupport` >= 8.0

---

## Generar clave manualmente

Si quieres generar la clave manualmente:

```bash
openssl rand -hex 16 > config/credentials/development.key
```

---

## Inspiración

- `Rails.application.credentials`
- `ActiveSupport::EncryptedFile`

---
