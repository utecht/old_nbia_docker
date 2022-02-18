FROM docker.io/bitnami/java:1.8 as builder
RUN install_packages ant
ADD installer/ /opt/installer
COPY config/install.properties /opt/installer
WORKDIR /opt/installer
RUN ant

FROM tomcat:9.0.58-jdk8-corretto

# ====== DELETE ======
# RUN yum install -y less vim yum-utils wget
# RUN yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
# RUN yum install -y ripgrep
# RUN wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/x/xmlstarlet-1.6.1-1.el7.x86_64.rpm
# RUN yum install -y xmlstarlet-1.6.1-1.el7.x86_64.rpm
# ==== ALL OF THIS ===

WORKDIR /usr/local/tomcat

COPY --from=builder /opt/nbia /opt/nbia
RUN cp -r /opt/nbia/conf/* conf
RUN cp -r /opt/nbia/lib/* lib
COPY ./tomcat-users.xml conf/
COPY ./context.xml webapps.dist/host-manager/META-INF
COPY ./context.xml webapps.dist/manager/META-INF
COPY config/nbia.properties lib/
RUN echo "tomcat.util.scan. StandardJarScanFilter.jarsToSkip=bcprov*.jar" >> conf/catalina.properties
RUN cp -r webapps.dist/* webapps
RUN cp -r /opt/nbia/webapps/* webapps
RUN export JAVA_OPTS="$JAVA_OPTS -Djava.security.auth.login.config=$CATALINA_HOME/conf/jaas.config"
RUN sed -i 's/java.util.logging.ConsoleHandler.level = FINE/java.util.logging.ConsoleHandler.level = ALL/g' conf/logging.properties
COPY config/log4j.properties lib/log4j.properties
# RUN rm conf/logging.properties
# RUN rm lib/log4j.properties