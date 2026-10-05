# Keycloak 26 com os temas travel4tech, keywind e viajis e os providers Apple e Discord.
# Cluster (se houver mais de uma réplica): JDBC_PING nativo (KC_CACHE_STACK=jdbc-ping), usa o datasource do Keycloak.
FROM quay.io/keycloak/keycloak:26.3 AS builder

ARG KC_HEALTH_ENABLED KC_METRICS_ENABLED KC_FEATURES KC_DB KC_HTTP_ENABLED QUARKUS_TRANSACTION_MANAGER_ENABLE_RECOVERY KC_HOSTNAME KC_LOG_LEVEL KC_DB_POOL_MIN_SIZE

# Opções de build: têm de ser iguais no arranque (--optimized).
ENV KC_CACHE=ispn KC_CACHE_STACK=jdbc-ping

ADD --chown=keycloak:keycloak https://github.com/klausbetz/apple-identity-provider-keycloak/releases/download/1.15.0/apple-identity-provider-1.15.0.jar /opt/keycloak/providers/apple-identity-provider-1.15.0.jar
ADD --chown=keycloak:keycloak https://github.com/wadahiro/keycloak-discord/releases/download/v0.6.1/keycloak-discord-0.6.1.jar /opt/keycloak/providers/keycloak-discord-0.6.1.jar
COPY /theme/keywind /opt/keycloak/themes/keywind
COPY /theme/travel4tech /opt/keycloak/themes/travel4tech
COPY /theme/viajis /opt/keycloak/themes/viajis

# Fixa os mtimes dos providers antes do build para o --optimized não achar que mudaram (keycloak#41268).
RUN find /opt/keycloak/providers -type f -exec touch -a -m --date=@0 {} + \
    && /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:26.3

ENV KC_CACHE=ispn KC_CACHE_STACK=jdbc-ping

COPY java.config /etc/crypto-policies/back-ends/java.config

COPY --from=builder /opt/keycloak/ /opt/keycloak/
COPY --chown=keycloak:keycloak --chmod=0755 docker-entrypoint.sh /opt/keycloak/bin/docker-entrypoint.sh

ENTRYPOINT ["/opt/keycloak/bin/docker-entrypoint.sh"]

CMD ["start", "--optimized", "--import-realm"]
