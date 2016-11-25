#!/bin/bash

if [ $KEYCLOAK_USER ] && [ $KEYCLOAK_PASSWORD ]; then
    keycloak/bin/add-user-keycloak.sh --user $KEYCLOAK_USER --password $KEYCLOAK_PASSWORD
fi

export HOSTNAME_IP=$(hostname -i)

exec /opt/jboss/keycloak/bin/standalone.sh -Djboss.bind.address.private=$HOSTNAME_IP $@
exit $?
