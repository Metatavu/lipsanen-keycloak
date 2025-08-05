FROM quay.io/keycloak/keycloak:24.0 as builder
WORKDIR /opt/keycloak
ADD providers /opt/keycloak/providers
ADD theme /opt/keycloak/themes/lipsanen
ENV KC_DB=mysql
ENV KC_HEALTH_ENABLED=true
ENV KC_PROXY=edge

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:24.0
ENV KC_DB=mysql
ENV KC_HEALTH_ENABLED=true
ENV KC_PROXY=edge

COPY --from=builder /opt/keycloak/ /opt/keycloak/