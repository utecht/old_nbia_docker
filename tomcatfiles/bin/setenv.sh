# Get configurations for catalina.sh

    CATALINA_CFG="../conf/init.conf"

 [ -r "$CATALINA_CFG" ] && . "${CATALINA_CFG}"

JAVA_OPTS="$JAVA_OPTS -Djava.security.auth.login.config=/Users/joseph/work/nbia_container/tomcatfiles/conf/jaas.config"
