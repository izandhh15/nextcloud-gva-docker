#!/bin/bash
until [ -f /var/www/html/config/config.php ]; do sleep 5; done
sleep 10

occ() { sudo -u www-data php /var/www/html/occ "$@"; }

occ app:enable user_ldap
occ ldap:create-empty-config s01
occ ldap:set-config s01 ldapHost "${LDAP_HOST}"
occ ldap:set-config s01 ldapPort "389"
occ ldap:set-config s01 ldapAgentName "${LDAP_BIND_DN}"
occ ldap:set-config s01 ldapAgentPassword "${LDAP_PASSWORD}"
occ ldap:set-config s01 ldapBase "${LDAP_BASE}"
occ ldap:set-config s01 ldapUserFilter "(&(objectClass=user)(sAMAccountName=*)(mail=*@edu.gva.es)(!(mail=*@alu.edu.gva.es))(memberOf=${LDAP_GROUP}))"
occ ldap:set-config s01 ldapLoginFilter "(&(&(objectClass=user)(mail=*@edu.gva.es)(!(mail=*@alu.edu.gva.es))(memberOf=${LDAP_GROUP}))(|(sAMAccountName=%uid)(mail=%uid)))"
occ ldap:set-config s01 ldapConfigurationActive 1
