#!/bin/bash

# Colors per a la terminal
VERD='\033[0;32m'
BLAU='\033[0;34m'
GROC='\033[1;33m'
RESET='\033[0m'

clear
echo -e "${BLAU}=========================================================="
echo -e "   INSTAL·LADOR INTERACTIU NEXTCLOUD + LDAP GVA"
echo -e "==========================================================${RESET}"
echo -e "Este script t'ajudarà a configurar el teu entorn de forma segura.\n"

# Funció per a preguntar
preguntar() {
    local variable=$1
    local texto=$2
    local defecto=$3
    local valor
    
    echo -e "${GROC}?> ${texto}${RESET}"
    [ ! -z "$defecto" ] && echo -e "   (Deixa en blanc per a usar: $defecto)"
    read -p "   > " valor
    
    if [ -z "$valor" ]; then
        eval "$variable='$defecto'"
    else
        eval "$variable='$valor'"
    fi
    echo ""
}

# --- Preguntes de Xarxa ---
echo -e "${VERD}[1/4] CONFIGURACIÓ DE XARXA INTERNA${RESET}"
preguntar "SERVER_IP" "Introdueix la IP interna del servidor (ej: 192.168.1.50)" "localhost"

# --- Preguntes de Base de Dades ---
echo -e "${VERD}[2/4] CONFIGURACIÓ DE BASE DE DADES${RESET}"
preguntar "DB_ROOT_PASS" "Introdueix la clau mestra (ROOT) per a MariaDB" "root_pass_$(date +%s)"
preguntar "DB_USER_PASS" "Introdueix la clau per a l'usuari 'nextcloud' de la DB" "db_pass_$(date +%s)"

# --- Preguntes de Nextcloud ---
echo -e "${VERD}[3/4] CONFIGURACIÓ D'ADMINISTRADOR NEXTCLOUD${RESET}"
preguntar "NC_ADMIN_USER" "Nom de l'usuari administrador de Nextcloud" "admin"
preguntar "NC_ADMIN_PASS" "Contrasenya de l'administrador de Nextcloud" "admin_pass_$(date +%s)"

# --- Preguntes de LDAP ---
echo -e "${VERD}[4/4] CONFIGURACIÓ LDAP GVA${RESET}"
preguntar "L_HOST" "Adreça del servidor LDAP" "ldapad.edu.gva.es"
preguntar "L_BIND_DN" "DN de l'usuari de consulta" "cn=consulta_DA,ou=educacion,dc=edu,dc=gva,dc=es"
preguntar "L_PASS" "Contrasenya de l'usuari de consulta (PISTA: busca en sssd.conf)" ""
preguntar "L_BASE" "Base de cerca LDAP" "dc=edu,dc=gva,dc=es"
preguntar "L_CODE" "Codi del centre (ej: 46026160)" ""

# Construir el DN del grup
L_GROUP="cn=GRP_${L_CODE},ou=educacion,dc=edu,dc=gva,dc=es"

# --- Generar l'arxiu .env ---
echo -e "${BLAU}Generant arxiu .env...${RESET}"

cat <<EOT > .env
SERVER_IP=${SERVER_IP}
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

echo -e "${VERD}=========================================================="
echo -e "   CONFIGURACIÓ COMPLETADA AMB ÈXIT"
echo -e "=========================================================="
echo -e "${RESET}S'ha creat l'arxiu ${GROC}.env${RESET} amb les teues dades."
echo -e "Ara pots iniciar el desplegament amb:"
echo -e "${BLAU}docker-compose up -d --build${RESET}\n"
