FROM jboss/keycloak:2.5.1.Final

ENV JB_HOME /opt/jboss
ENV KC_HOME ${JB_HOME}/keycloak
ENV CFG_FILE ${KC_HOME}/standalone/configuration/standalone-ha.xml
ENV WEB_XML ${KC_HOME}/modules/system/layers/keycloak/org/keycloak/keycloak-server-subsystem/main/server-war/WEB-INF/web.xml

ADD *.xsl ${KC_HOME}/
ADD docker-entrypoint.sh ${JB_HOME}
ADD themes/akvo/ ${KC_HOME}/themes/akvo/

RUN java -jar /usr/share/java/saxon.jar -s:${CFG_FILE} -xsl:${KC_HOME}/changeDatabase.xsl -o:${CFG_FILE}; \
    java -jar /usr/share/java/saxon.jar -s:${CFG_FILE} -xsl:${KC_HOME}/changeDiscovery.xsl -o:${CFG_FILE}; \
    java -jar /usr/share/java/saxon.jar -s:${CFG_FILE} -xsl:${KC_HOME}/changeProxy.xsl -o:${CFG_FILE}; \
    rm ${KC_HOME}/*.xsl;

RUN mkdir -p ${KC_HOME}/modules/system/layers/base/com/mysql/jdbc/main; \
    cd ${KC_HOME}/modules/system/layers/base/com/mysql/jdbc/main && \
    curl -O http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.18/mysql-connector-java-5.1.18.jar

ADD module.xml ${KC_HOME}/modules/system/layers/base/com/mysql/jdbc/main/

CMD ["-b", "0.0.0.0", "--server-config", "standalone-ha.xml"]
