FROM nextcloud:latest
RUN apt-get update && apt-get install -y libldap2-dev sudo \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install ldap
COPY setup-ldap.sh /setup-ldap.sh
RUN chmod +x /setup-ldap.sh
