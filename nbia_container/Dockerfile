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
ADD installer.tar /opt
COPY install.properties /opt/installer
WORKDIR /opt/installer
RUN ant

FROM tomcat:9.0.58-jdk8-corretto

# ====== DELETE ======
RUN yum install -y less vim yum-utils wget
RUN yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
RUN yum install -y ripgrep
RUN wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/x/xmlstarlet-1.6.1-1.el7.x86_64.rpm
RUN yum install -y xmlstarlet-1.6.1-1.el7.x86_64.rpm
# ==== ALL OF THIS ===

WORKDIR /usr/local/tomcat

COPY --from=builder /opt/nbia /opt/nbia
RUN cp -r /opt/nbia/conf/* conf
RUN cp -r /opt/nbia/lib/* lib
COPY ./tomcat-users.xml conf/
COPY ./context.xml webapps.dist/host-manager/META-INF
COPY ./context.xml webapps.dist/manager/META-INF
RUN echo "tomcat.util.scan. StandardJarScanFilter.jarsToSkip=bcprov*.jar" >> conf/catalina.properties
RUN cp -r webapps.dist/* webapps
RUN cp -r /opt/nbia/webapps/* webapps
RUN export JAVA_OPTS="$JAVA_OPTS -Djava.security.auth.login.config=$CATALINA_HOME/conf/jaas.config"

WORKDIR /usr/local/tomcat/bin
CMD ["catalina.sh" "run"]