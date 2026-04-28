# Nextcloud GVA Zero-Touch (Docker)

Despliegue automático de Nextcloud con integración LDAP configurada para centros educativos de la GVA.

## Requisitos
* Docker y Docker Compose

## Instalación
1. Copia el archivo de ejemplo: `cp .env.example .env`
2. Edita `env` con tus credenciales.
3. Levanta el servicio:
   ```bash
   docker-compose up -d --build
   ```

## Seguridad
Este despliegue restringe el acceso solo a profesores del grupo especificado y bloquea automáticamente al alumnado (@alu.edu.gva.es).
