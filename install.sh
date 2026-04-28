#!/bin/bash

# Colors / Colores
VERD='\033[0;32m'
BLAU='\033[0;34m'
GROC='\033[1;33m'
RESET='\033[0m'

clear
echo -e "${BLAU}=========================================================="
echo -e "   INSTAL·LADOR / INSTALADOR NEXTCLOUD + LDAP GVA"
echo -e "==========================================================${RESET}"

# Funció per a preguntar
preguntar() {
    local variable=$1
    local texto_val=$2
    local texto_cas=$3
    local defecto=$4
    local valor
    
    echo -e "${GROC}?> ${texto_val} / ${texto_cas}${RESET}"
    [ ! -z "$defecto" ] && echo -e "   (Default: $defecto)"
    read -p "   > " valor
    
    if [ -z "$valor" ]; then
        eval "$variable='$defecto'"
    else
        eval "$variable='$valor'"
    fi
    echo ""
}

# --- Xarxa / Red ---
echo -e "${VERD}[1/4] XARXA I PORTS / RED Y PUERTOS${RESET}"
preguntar "SERVER_IP" "IP interna del servidor" "IP interna del servidor" "localhost"
preguntar "SERVER_PORT" "Port per al servei" "Puerto para el servicio" "8080"

# --- Base de Dades / DB ---
echo -e "${VERD}[2/4] BASE DE DADES / BASE DE DATOS${RESET}"
preguntar "DB_ROOT_PASS" "Clau ROOT MariaDB" "Clave ROOT MariaDB" "root_pass_$(date +%s)"
preguntar "DB_USER_PASS" "Clau usuari Nextcloud" "Clave usuario Nextcloud" "db_pass_$(date +%s)"

# --- Nextcloud ---
echo -e "${VERD}[3/4] ADMINISTRADOR NEXTCLOUD${RESET}"
preguntar "NC_ADMIN_USER" "Nom administrador" "Nombre administrador" "admin"
preguntar "NC_ADMIN_PASS" "Contrasenya" "Contraseña" "admin_pass_$(date +%s)"

# --- LDAP ---
echo -e "${VERD}[4/4] CONFIGURACIÓ LDAP GVA${RESET}"
preguntar "L_HOST" "Servidor LDAP" "Servidor LDAP" "ldapad.edu.gva.es"
preguntar "L_BIND_DN" "DN Agente" "DN Agente" "cn=consulta_DA,ou=educacion,dc=edu,dc=gva,dc=es"
preguntar "L_PASS" "Contrasenya consulta" "Contraseña consulta" ""
preguntar "L_BASE" "Base cerca" "Base búsqueda" "dc=edu,dc=gva,dc=es"
preguntar "L_CODE" "Codi centre (ej: 46026160)" "Código centro" ""

L_GROUP="cn=GRP_${L_CODE},ou=educacion,dc=edu,dc=gva,dc=es"

# --- Generar .env ---
cat <<EOT > .env
SERVER_IP=${SERVER_IP}
SERVER_PORT=${SERVER_PORT}
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
echo -e "${VERD}Configuració completada / Configuración completada${RESET}"
