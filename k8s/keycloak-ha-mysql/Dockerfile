# The last released Docker image from 2.5.x series
# https://github.com/jboss-dockerfiles/keycloak/blob/2.5.5.Final/server/Dockerfile
FROM jboss/base-jdk:8

ENV KEYCLOAK_VERSION 2.5.6.Final
# Enables signals getting passed from startup script to JVM
# ensuring clean shutdown when container is stopped.
ENV LAUNCH_JBOSS_IN_BACKGROUND 1

USER root

RUN yum install -y epel-release && yum install -y jq && yum clean all

USER jboss

COPY keycloak-$KEYCLOAK_VERSION.tar.gz /opt/jboss/

RUN cd /opt/jboss/ && \
    tar zxf keycloak-$KEYCLOAK_VERSION.tar.gz && \
    mv /opt/jboss/keycloak-$KEYCLOAK_VERSION /opt/jboss/keycloak && \
    rm -rf /opt/jboss/keycloak-$KEYCLOAK_VERSION.tar.gz

COPY docker-entrypoint.sh /opt/jboss/

COPY setLogLevel.xsl /opt/jboss/keycloak/

RUN java -jar /usr/share/java/saxon.jar \
    -s:/opt/jboss/keycloak/standalone/configuration/standalone.xml \
    -xsl:/opt/jboss/keycloak/setLogLevel.xsl \
    -o:/opt/jboss/keycloak/standalone/configuration/standalone.xml

ENV JBOSS_HOME /opt/jboss/keycloak

# Custom directives

ENV CFG_FILE $JBOSS_HOME/standalone/configuration/standalone-ha.xml

COPY *.xsl $JBOSS_HOME/

RUN java -jar /usr/share/java/saxon.jar -s:$CFG_FILE -xsl:$JBOSS_HOME/changeDatabase.xsl -o:$CFG_FILE; \
    java -jar /usr/share/java/saxon.jar -s:$CFG_FILE -xsl:$JBOSS_HOME/changeDiscovery.xsl -o:$CFG_FILE; \
    java -jar /usr/share/java/saxon.jar -s:$CFG_FILE -xsl:$JBOSS_HOME/changeProxy.xsl -o:$CFG_FILE; \
    rm -rf $JBOSS_HOME/*.xsl;

RUN mkdir -p $JBOSS_HOME/modules/system/layers/base/com/mysql/jdbc/main; \
    cd $JBOSS_HOME/modules/system/layers/base/com/mysql/jdbc/main && \
    curl -O http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.18/mysql-connector-java-5.1.18.jar

COPY module.xml $JBOSS_HOME/modules/system/layers/base/com/mysql/jdbc/main/

EXPOSE 8080

ENTRYPOINT [ "/opt/jboss/docker-entrypoint.sh" ]

CMD ["-b", "0.0.0.0", "--server-config", "standalone-ha.xml"]
