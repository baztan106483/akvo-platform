<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:javaee="http://java.sun.com/xml/ns/javaee">

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="//javaee:web-app/*[position()=last()]">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
    <xsl:element name="security-constraint" namespace="http://java.sun.com/xml/ns/javaee">
      <xsl:element name="web-resource-collection" namespace="http://java.sun.com/xml/ns/javaee">
	<xsl:element name="url-pattern" namespace="http://java.sun.com/xml/ns/javaee">/admin/*</xsl:element>
	<xsl:element name="url-pattern" namespace="http://java.sun.com/xml/ns/javaee">/realms/*</xsl:element>
      </xsl:element>
      <xsl:element name="user-data-constraint" namespace="http://java.sun.com/xml/ns/javaee">
	<xsl:element name="transport-guarantee" namespace="http://java.sun.com/xml/ns/javaee">CONFIDENTIAL</xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
