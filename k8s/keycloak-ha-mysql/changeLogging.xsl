<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:log="urn:jboss:domain:logging:3.0"
		exclude-result-prefixes="log">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="//log:subsystem/log:console-handler[@name='CONSOLE']/log:formatter/log:named-formatter[@name='COLOR-PATTERN']">
	<named-formatter name="PATTERN" />
    </xsl:template>

    <xsl:template match="//log:subsystem/log:root-logger/log:handlers">
	<handlers>
		<handler name="CONSOLE" />
	</handlers>
    </xsl:template>

    <xsl:template match="//log:subsystem">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
                <logger category="org.keycloak">
                    <level>
                      <xsl:attribute name="name">${env.KEYCLOAK_LOGLEVEL:INFO}</xsl:attribute>
                    </level>
                </logger>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>

