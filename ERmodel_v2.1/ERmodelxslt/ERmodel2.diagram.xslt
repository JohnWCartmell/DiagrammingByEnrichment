<!-- 

-->

<!-- 
*****************
ERmodel2.diagram.xslt
*****************

DESCRIPTION
  Transform an instance of ERmodelERmodel to a diagram.

CHANGE HISTORY
         JC  12-Sept-2019 Created
-->
<xsl:transform version="2.0" 
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:math="http://www.w3.org/2005/xpath-functions/math"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"       
		xmlns:xlink="http://www.w3.org/TR/xlink" 
		xmlns:svg="http://www.w3.org/2000/svg" 
		xmlns:diagram="http://www.entitymodelling.org/diagram" 
		xpath-default-namespace="http://www.entitymodelling.org/ERmodel"
		xmlns="http://www.entitymodelling.org/diagram"
		>

	<xsl:include href="passone.xslt"/>

	<xsl:include href="passtwo.xslt"/>

	<xsl:output method="xml" indent="yes" />

	<xsl:template name="main" match="entity_model">

		<xsl:variable name="state">
			<diagram:diagram>
				<xsl:namespace name=""  select="'http://www.entitymodelling.org/diagram'"/>
				<include>
					<filename>shared/text_style_definitions.xml</filename>
				</include>
				<include>
					<filename>shared/shape_style_definitions.xml</filename>
				</include>
				<include>
					<filename>shared/endline_style_definitions.xml</filename>
				</include>
				<default>
					<hmin>1.0</hmin>
					<wmin>1.0</wmin>
					<margin>0.2</margin>
					<padding>0.15</padding>
					<packing>horizontal</packing>
					<text_style>normal</text_style>
					<shape_style>outline</shape_style>
					<debug-whitespace>true</debug-whitespace>
					<end_style>testline</end_style>
				</default>
				<xsl:apply-templates select="absolute|entity_type|group" mode="passzero"/>
				<xsl:apply-templates select="//composition" mode="passzero"/>
			</diagram:diagram>	
		</xsl:variable>


		<xsl:variable name="state">
			<xsl:for-each select="$state/*">
				<xsl:copy>
					<xsl:apply-templates mode="passone"/>
				</xsl:copy>
			</xsl:for-each>
		</xsl:variable>	
		<xsl:variable name="state">
			<xsl:for-each select="$state/*">
				<xsl:copy>
					<xsl:apply-templates mode="passtwo"/>
				</xsl:copy>
			</xsl:for-each>
		</xsl:variable>	
		<xsl:variable name="state">
			<xsl:for-each select="$state/*">
				<xsl:copy>
					<xsl:apply-templates mode="passthree"/>
				</xsl:copy>
			</xsl:for-each>
		</xsl:variable>	
		<xsl:for-each select="$state/*">
			<xsl:copy>
				<xsl:apply-templates mode="passfour"/>
			</xsl:copy>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="absolute" mode="passzero">
		<xsl:message>passzero</xsl:message>
		<enclosure>
			<id><xsl:value-of select="name"/></id>
			<shape_style>entity_type_outline</shape_style>
			<label/>
		</enclosure>
	</xsl:template>

	<xsl:template match="entity_type" mode="passzero">
		<enclosure>
			<id><xsl:value-of select="name"/></id>
			<shape_style>entity_type_outline</shape_style>
			<label/>
			<xsl:apply-templates select="entity_type|group" mode="passzero"/>
			<xsl:copy-of select="diagram:enclosure/*"/>
		</enclosure>
	</xsl:template>

	<xsl:template match="group" mode="passzero">
		<enclosure>
			<id><xsl:value-of select="name"/></id>
			<shape_style>group_outline</shape_style>
			<label/>
			<xsl:apply-templates select="entity_type|group" mode="passzero"/>
		</enclosure>
	</xsl:template>

	<xsl:template match="composition" mode="passzero">
		<route>
			<top_down/>
			<source>
				<id><xsl:value-of select="../name"/></id>
				<annotation><xsl:value-of select="name"/></annotation>
			</source>
			<destination>
				<id><xsl:value-of select="type"/></id>
				<annotation><xsl:value-of select="inverse"/></annotation>
			</destination>			
		</route>
	</xsl:template>

	<xsl:template match="*"/>

</xsl:transform>