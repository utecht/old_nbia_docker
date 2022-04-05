FROM jrutecht/bitnami-tomcat9-jdk18:v1.0

COPY tomcatfiles/webapps /opt/bitnami/tomcat/webapps_default
COPY tomcatfiles/conf /opt/bitnami/tomcat/conf
COPY tomcatfiles/lib /opt/bitnami/tomcat/lib

RUN chmod g+w -R /opt/bitnami/tomcat

RUN mkdir /opt/dicoms
RUN chmod g+w -R /opt/dicoms

ENV ALLOW_EMPTY_PASSWORD="yes" \
    TOMCAT_ALLOW_REMOTE_MANAGEMENT="yes" \
    TOMCAT_USERNAME="admin" \
    TOMCAT_PASSWORD="admin" \
    TOMCAT_EXTRA_JAVA_OPTS="-Djava.security.auth.login.config=/opt/bitnami/tomcat/conf/jaas.config -Dlog4j.configuration"
USER 1001
