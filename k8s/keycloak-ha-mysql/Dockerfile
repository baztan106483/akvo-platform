FROM jboss/keycloak:2.4.0.Final

ADD *.xsl /opt/jboss/keycloak/
ADD docker-entrypoint.sh /opt/jboss

RUN java -jar /usr/share/java/saxon.jar -s:/opt/jboss/keycloak/standalone/configuration/standalone.xml -xsl:/opt/jboss/keycloak/changeDatabase.xsl -o:/opt/jboss/keycloak/standalone/configuration/standalone.xml; java -jar /usr/share/java/saxon.jar -s:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml -xsl:/opt/jboss/keycloak/changeDatabase.xsl -o:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml; java -jar /usr/share/java/saxon.jar -s:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml -xsl:/opt/jboss/keycloak/changeDiscovery.xsl -o:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml; rm /opt/jboss/keycloak/*.xsl;

RUN mkdir -p /opt/jboss/keycloak/modules/system/layers/base/com/mysql/jdbc/main; cd /opt/jboss/keycloak/modules/system/layers/base/com/mysql/jdbc/main && curl -O http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.18/mysql-connector-java-5.1.18.jar
ADD module.xml /opt/jboss/keycloak/modules/system/layers/base/com/mysql/jdbc/main/

CMD ["-b", "0.0.0.0", "--server-config", "standalone-ha.xml"]
