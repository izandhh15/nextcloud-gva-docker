#!/bin/bash
VERD='\033[0;32m'; BLAU='\033[0;34m'; GROC='\033[1;33m'; RESET='\033[0m'
clear
echo -e "${BLAU}=========================================================="
echo -e "   ASSISTENT D.INSTAL·LACIÓ (VALENCIÀ)"
echo -e "==========================================================${RESET}"

preguntar() {
    local variable=$1; local texto=$2; local defecto=$3; local valor
    echo -e "${GROC}?> $texto${RESET}"
    [ ! -z "$defecto" ] && echo -e "   (Per defecte: $defecto)"
    read -p "   > " valor
    [ -z "$valor" ] && eval "$variable='$defecto'" || eval "$variable='$valor'"
    echo ""
}

preguntar "SERVER_IP" "IP interna del servidor" "localhost"
preguntar "SERVER_PORT" "Port per al servei" "8080"
preguntar "DB_ROOT_PASS" "Clau ROOT MariaDB" "root_pass_$(date +%s)"
preguntar "DB_USER_PASS" "Clau usuari Nextcloud DB" "db_pass_$(date +%s)"
preguntar "NC_ADMIN_USER" "Nom administrador web" "admin"
preguntar "NC_ADMIN_PASS" "Contrasenya administrador web" "admin_pass_$(date +%s)"
preguntar "L_HOST" "Servidor LDAP GVA" "ldapad.edu.gva.es"
preguntar "L_BIND_DN" "DN Agent consulta" "cn=consulta_DA,ou=educacion,dc=edu,dc=gva,dc=es"
preguntar "L_PASS" "Contrasenya consulta" ""
preguntar "L_BASE" "Base de cerca" "dc=edu,dc=gva,dc=es"
preguntar "L_CODE" "Codi del centre (ej: 46026160)" ""

L_GROUP="cn=GRP_${L_CODE},ou=educacion,dc=edu,dc=gva,dc=es"

cat <<EOT > .env
SERVER_IP=${SERVER_IP}
SERVER_PORT=${SERVER_PORT}
NEXTCLOUD_LANGUAGE=ca
MYSQL_ROOT_PASSWORD=${DB_ROOT_PASS}
MYSQL_PASSWORD=${DB_USER_PASS}
MYSQL_DATABASE=nextcloud
MYSQL_USER=nextcloud
NEXTCLOUD_ADMIN_USER=${NC_ADMIN_USER}
NEXTCLOUD_ADMIN_PASSWORD=${NC_ADMIN_PASS}
NEXTCLOUD_TRUSTED_DOMAINS=${SERVER_IP}
LDAP_HOST=${L_HOST}
LDAP_BIND_DN=${L_BIND_DN}
LDAP_PASSWORD=${L_PASS}
LDAP_BASE=${L_BASE}
LDAP_GROUP=${L_GROUP}
EOT

chmod 600 .env
echo -e "${VERD}Configuració finalitzada. Nextcloud s'instal·larà en Valencià.${RESET}"
echo -e "Executa: ${BLAU}docker-compose up -d --build${RESET}"
