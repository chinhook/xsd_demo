<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tns="http://www.thalesgroup.com/avionics/clusters" xmlns:fm2xx="http://www.thalesgroup.com/avionics/irs2xxattributes"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs tns fm2xx">
	<xsl:output method="xhtml" media-type="text/xml"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" />

	<xsl:template match="/">
		<html>
			<head>
				<title>
					Interface Requirement Specification
				</title>
			</head>
			<xsl:apply-templates mode="#current" />
		</html>
	</xsl:template>


	<xsl:template match="xs:schema">
		<body>
			<h1>Interface Requirement Specification</h1>

			<h2>Primitive type encoding definitions</h2>
			<ul>
				<li>Endianness : Big endian</li>
				<li>xs:unsignedByte : 8 bits [0 .. 255]</li>
				<li>xs:unsignedShort : 16 bits [0 .. 65535]</li>
				<li>xs:unsignedInteger : 32 bits [0 .. 4294967295]</li>
				<li>xs:float : 32 bits IEEE754</li>
			</ul>

			<h2>Simple type definitions</h2>
			<ul>
				<xsl:for-each select="xs:simpleType">
					<li>
						<xsl:call-template name="simpleContentTemplate" />
					</li>
				</xsl:for-each>
			</ul>
			<h2>Complex type definitions</h2>
			<ul>
				<xsl:for-each select="xs:complexType">
					<li>
						<xsl:call-template name="complexContentTemplate" />
					</li>
				</xsl:for-each>
			</ul>

		</body>
	</xsl:template>


	<xsl:template name="simpleContentTemplate">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template name="complexContentTemplate">
		<div><xsl:value-of select="@name"/> is record :</div>
		<xsl:apply-templates select="descendant::xs:sequence" />
	</xsl:template>

	<xsl:template match="xs:simpleType/xs:restriction">
		<div>
			Enum <xsl:value-of select="../@name" /> derived from 
			<xsl:value-of select="@base"></xsl:value-of>
		</div>
		<ul>
			<xsl:for-each select="xs:enumeration">
				<li>
					<xsl:apply-templates select="descendant-or-self::node()" />
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>

	<xsl:template match="xs:enumeration">
		<p>
			<xsl:value-of select="@fm2xx:literal" />
			=
			<xsl:value-of select="@value" />
		</p>
	</xsl:template>

	<xsl:template match="xs:sequence">
		<ul>
			<xsl:for-each select="xs:element">
				<li>
					<p>
						<xsl:value-of select="@name" />
						:
						<xsl:value-of select="@type" />
						[
						<xsl:value-of select="@minOccurs" />
						,
						<xsl:value-of select="maxOccurs"></xsl:value-of>
						]
					</p>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>

</xsl:stylesheet>