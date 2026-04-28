#!/bin/bash

# Colores para la terminal
VERDE='\033[0;32m'
AZUL='\033[0;34m'
AMARILLO='\033[1;33m'
RESET='\033[0m'

clear
echo -e "${AZUL}=========================================================="
echo -e "   INSTALADOR INTERACTIVO NEXTCLOUD + LDAP GVA"
echo -e "==========================================================${RESET}"
echo -e "Este script te ayudara a configurar tu entorno de forma segura.\n"

# Función para preguntar
preguntar() {
    local variable=$1
    local texto=$2
    local defecto=$3
    local valor
    
    echo -e "${AMARILLO}?> ${texto}${RESET}"
    [ ! -z "$defecto" ] && echo -e "   (Dejar en blanco para usar: $defecto)"
    read -p "   > " valor
    
    if [ -z "$valor" ]; then
        eval "$variable='$defecto'"
    else
        eval "$variable='$valor'"
    fi
    echo ""
}

# --- Preguntas de Base de Datos ---
echo -e "${VERDE}[1/3] CONFIGURACIÓN DE BASE DE DATOS${RESET}"
preguntar "DB_ROOT_PASS" "Introduce la clave maestra (ROOT) para MariaDB" "root_pass_1777379569"
preguntar "DB_USER_PASS" "Introduce la clave para el usuario 'nextcloud' de la DB" "db_pass_1777379569"

# --- Preguntas de Nextcloud ---
echo -e "${VERDE}[2/3] CONFIGURACIÓN DE ADMINISTRADOR NEXTCLOUD${RESET}"
preguntar "NC_ADMIN_USER" "Nombre del usuario administrador de Nextcloud" "admin"
preguntar "NC_ADMIN_PASS" "Contraseña del administrador de Nextcloud" "admin_pass_1777379569"

# --- Preguntas de LDAP ---
echo -e "${VERDE}[3/3] CONFIGURACIÓN LDAP GVA${RESET}"
preguntar "L_HOST" "Dirección del servidor LDAP" "ldapad.edu.gva.es"
preguntar "L_BIND_DN" "DN del usuario de consulta" "cn=consulta_DA,ou=educacion,dc=edu,dc=gva,dc=es"
preguntar "L_PASS" "Contraseña del usuario de consulta (PISTA: busca en sssd.conf)" ""
preguntar "L_BASE" "Base de búsqueda LDAP" "dc=edu,dc=gva,dc=es"
preguntar "L_CODE" "Código del centro (ej: 46026160)" ""

# Construir el DN del grupo
L_GROUP="cn=GRP_${L_CODE},ou=educacion,dc=edu,dc=gva,dc=es"

# --- Generar el archivo .env ---
echo -e "${AZUL}Generando archivo .env...${RESET}"

cat <<EOT > .env
MYSQL_ROOT_PASSWORD=${DB_ROOT_PASS}
MYSQL_PASSWORD=${DB_USER_PASS}
MYSQL_DATABASE=nextcloud
MYSQL_USER=nextcloud

NEXTCLOUD_ADMIN_USER=${NC_ADMIN_USER}
NEXTCLOUD_ADMIN_PASSWORD=${NC_ADMIN_PASS}

LDAP_HOST=${L_HOST}
LDAP_BIND_DN=${L_BIND_DN}
LDAP_PASSWORD=${L_PASS}
LDAP_BASE=${L_BASE}
LDAP_GROUP=${L_GROUP}
EOT

chmod 600 .env

echo -e "${VERDE}=========================================================="
echo -e "   CONFIGURACIÓN COMPLETADA CON ÉXITO"
echo -e "=========================================================="
echo -e "${RESET}Se ha creado el archivo ${AMARILLO}.env${RESET} con tus datos."
echo -e "Ahora puedes iniciar el despliegue con:"
echo -e "${AZUL}docker-compose up -d --build${RESET}\n"
