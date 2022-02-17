FROM docker.io/bitnami/minideb:buster as builder
LABEL maintainer "Bitnami <containers@bitnami.com>"

ENV HOME="/" \
    OS_ARCH="amd64" \
    OS_FLAVOUR="debian-10" \
    OS_NAME="linux"

ARG JAVA_EXTRA_SECURITY_DIR="/bitnami/java/extra-security"

COPY prebuildfs /
# Install required system packages and dependencies
RUN install_packages acl ca-certificates curl gzip libc6 libssl1.1 procps tar xmlstarlet zlib1g
RUN . /opt/bitnami/scripts/libcomponent.sh && component_unpack "java" "1.8.242-0" --checksum 3a70f3d1c3cd9bc6ec581b2a10373a2b323c0b9af40402ce8d19aeb0b3d02400
RUN install_packages ant
RUN apt-get update && apt-get upgrade -y && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives
RUN chmod g+rwX /opt/bitnami

COPY rootfs /
RUN /opt/bitnami/scripts/java/postunpack.sh
ENV BITNAMI_APP_NAME="builder" \
    BITNAMI_IMAGE_VERSION="8.5.75-debian-10-r23" \
    JAVA_HOME="/opt/bitnami/java" \
    PATH="/opt/bitnami/java/bin:/opt/bitnami/common/bin:$PATH"
ADD installer.tar.gz /opt
COPY install.properties /opt/installer
WORKDIR /opt/installer
RUN ls
RUN ant

FROM tomcat:7.0.109-jdk8-openjdk
COPY --from=builder /opt/nbia /opt/nbia
COPY --from=builder /opt/installer /opt/installer
WORKDIR /opt/nbia
RUN cp -r conf /usr/local/tomcat
RUN cp -r lib /usr/local/tomcat
RUN cp -r webapps/* /usr/local/tomcat/webapps
COPY ./tomcat-users.xml /usr/local/tomcat/conf
COPY ./context.xml /usr/local/tomcat/webapps.dist/host-manager/META-INF
COPY ./context.xml /usr/local/tomcat/webapps.dist/manager/META-INF
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]
