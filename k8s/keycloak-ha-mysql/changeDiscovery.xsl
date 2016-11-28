<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:jg="urn:jboss:domain:jgroups:4.0"
		exclude-result-prefixes="jg">

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="//jg:subsystem/jg:stacks/jg:stack[@name='udp']/jg:transport[@type='UDP']">
    <transport type="UDP" socket-binding="jgroups-udp">
      <property name="ip_mcast">false</property>
    </transport>
  </xsl:template>

  <xsl:template match="//jg:subsystem/jg:stacks/jg:stack[@name='udp']/jg:protocol[@type='PING']">
    <protocol type="GOOGLE_PING">
      <property name="access_key">${env.GOOGLE_ACCESS_KEY}</property>
      <property name="secret_access_key">${env.GOOGLE_ACCESS_KEY_SECRET}</property>
      <property name="location">${env.GOOGLE_LOCATION}</property>
      <property name="timeout">2000</property>
      <property name="port">443</property>
      <property name="use_ssl">true</property>
      <property name="remove_old_coords_on_view_change">true</property>
      <property name="break_on_coord_rsp">true</property>
    </protocol>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
