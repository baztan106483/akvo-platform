<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ut="urn:jboss:domain:undertow:3.0"
  xmlns:srv="urn:jboss:domain:4.0"
  exclude-result-prefixes="ut srv">

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="//ut:subsystem/ut:server[@name='default-server']/ut:http-listener">
    <http-listener name="default" socket-binding="http" redirect-socket="proxy-https"
		   proxy-address-forwarding="true"/>
  </xsl:template>

  <xsl:template match="//srv:server/srv:socket-binding-group[@name='standard-sockets']/*[position()=1]">
    <xsl:element name="socket-binding" namespace="urn:jboss:domain:4.0">
      <xsl:attribute name="name">
	<xsl:value-of select="'proxy-https'"/>
      </xsl:attribute>
      <xsl:attribute name="port">
	<xsl:value-of select="'443'"/>
      </xsl:attribute>
    </xsl:element>
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
