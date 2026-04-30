#!/bin/bash
VERDE='\033[0;32m'; AZUL='\033[0;34m'; AMARILLO='\033[1;33m'; RESET='\033[0m'
clear
echo -e "${AZUL}=========================================================="
echo -e "   ASISTENTE DE INSTALACIÓN (CASTELLANO)"
echo -e "==========================================================${RESET}"

preguntar() {
    local variable=$1; local texto=$2; local defecto=$3; local valor
    echo -e "${AMARILLO}?> $texto${RESET}"
    [ ! -z "$defecto" ] && echo -e "   (Por defecto: $defecto)"
    read -p "   > " valor
    [ -z "$valor" ] && eval "$variable='$defecto'" || eval "$variable='$valor'"
    echo ""
}

preguntar "SERVER_IP" "IP interna del servidor" "localhost"
preguntar "SERVER_PORT" "Puerto para el servicio" "8080"
preguntar "DB_ROOT_PASS" "Clave ROOT MariaDB" "root_pass_$(date +%s)"
preguntar "DB_USER_PASS" "Clave usuario Nextcloud DB" "db_pass_$(date +%s)"
preguntar "NC_ADMIN_USER" "Nombre administrador web" "admin"
preguntar "NC_ADMIN_PASS" "Contraseña administrador web" "admin_pass_$(date +%s)"
preguntar "L_HOST" "Servidor LDAP GVA" "ldapad.edu.gva.es"
preguntar "L_BIND_DN" "DN Agente consulta" "cn=consulta_DA,ou=educacion,dc=edu,dc=gva,dc=es"
preguntar "L_PASS" "Contraseña consulta" ""
preguntar "L_BASE" "Base de búsqueda" "dc=edu,dc=gva,dc=es"
preguntar "L_CODE" "Código del centro (ej: 46026160)" ""

L_GROUP="cn=GRP_${L_CODE},ou=educacion,dc=edu,dc=gva,dc=es"

cat <<EOT > .env
SERVER_IP=${SERVER_IP}
SERVER_PORT=${SERVER_PORT}
NEXTCLOUD_LANGUAGE=es
MYSQL_ROOT_PASSWORD=${DB_ROOT_PASS}
MYSQL_PASSWORD=${DB_USER_PASS}
MYSQL_DATABASE=nextcloud
MYSQL_USER=nextcloud
NEXTCLOUD_ADMIN_USER=${NC_ADMIN_USER}
NEXTCLOUD_ADMIN_PASSWORD=${NC_ADMIN_PASS}
NEXTCLOUD_TRUSTED_DOMAINS="${SERVER_IP} iescloud.local"
LDAP_HOST=${L_HOST}
LDAP_BIND_DN=${L_BIND_DN}
LDAP_PASSWORD=${L_PASS}
LDAP_BASE=${L_BASE}
LDAP_GROUP=${L_GROUP}
EOT

chmod 600 .env
echo -e "${VERDE}Configuración finalizada. Nextcloud se instalará en Castellano.${RESET}"
echo -e "Ejecuta: ${AZUL}docker-compose up -d --build${RESET}"
