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
RUN . /opt/bitnami/scripts/libcomponent.sh && component_unpack "tomcat" "9.0.58-7" --checksum 5b5e92174e2174ab1a86c5ee2c32e4939638300cef60222b6e23dbfb76b49074
RUN . /opt/bitnami/scripts/libcomponent.sh && component_unpack "render-template" "1.0.1-8" --checksum 4694f01476c5a457a71f280562df45ea542bdf3f9b298ff87643a89ea365f5fb
RUN . /opt/bitnami/scripts/libcomponent.sh && component_unpack "gosu" "1.14.0-5" --checksum 6f8fd2267481ffbe899a7f93b7b3076cd78dd70b7b9835bed79414932a749664
RUN install_packages ant
RUN apt-get update && apt-get upgrade -y && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives
RUN chmod g+rwX /opt/bitnami

COPY rootfs /
RUN /opt/bitnami/scripts/java/postunpack.sh
RUN /opt/bitnami/scripts/tomcat/postunpack.sh
ENV BITNAMI_APP_NAME="builder" \
    BITNAMI_IMAGE_VERSION="8.5.75-debian-10-r23" \
    JAVA_HOME="/opt/bitnami/java" \
    PATH="/opt/bitnami/java/bin:/opt/bitnami/common/bin:/opt/bitnami/tomcat/bin:$PATH"
ADD --chown=1001:root installer.tar /opt
COPY --chown=1001:root install.properties /opt/installer
WORKDIR /opt/installer
RUN ant

WORKDIR /opt/nbia

RUN cp -r conf /opt/bitnami/tomcat
RUN cp -r lib /opt/bitnami/tomcat
COPY --chown=1001:root ./tomcat-users.xml /opt/bitnami/tomcat/conf
COPY --chown=1001:root ./context.xml /app/host-manager/META-INF
COPY --chown=1001:root ./context.xml /app/manager/META-INF
RUN echo "tomcat.util.scan. StandardJarScanFilter.jarsToSkip=bcprov*.jar" >> /opt/bitnami/tomcat/conf/catalina.properties
RUN cp -r /opt/bitnami/tomcat/webapps_default /app
RUN cp -r webapps/* /app

WORKDIR /opt/installer

USER 1001
ENTRYPOINT [ "/opt/bitnami/scripts/tomcat/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/tomcat/run.sh" ]