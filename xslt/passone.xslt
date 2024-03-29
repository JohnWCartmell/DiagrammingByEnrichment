

<xsl:transform version="2.0" 
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:math="http://www.w3.org/2005/xpath-functions/math"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"       
		xmlns:xlink="http://www.w3.org/TR/xlink" 
		xmlns:svg="http://www.w3.org/2000/svg" 
		xmlns:diagram="http://www.entitymodelling.org/diagram" 
		xpath-default-namespace="http://www.entitymodelling.org/diagram"
		xmlns="http://www.entitymodelling.org/diagram"
		>

	<xsl:output method="xml" indent="yes" />
    <xsl:key name="Enclosure" match="enclosure" use="id"/>

	<xsl:template match="*" mode="passone">
		<xsl:copy>
			<xsl:apply-templates mode="passone"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="source" mode="passone">
		<xsl:copy>
			<xsl:apply-templates mode="passone"/>
			 <abstract>
			   <xsl:value-of select="(key('Enclosure',id)/ancestor-or-self::enclosure 
			                         except key('Enclosure',../destination/id)/ancestor-or-self::enclosure)
			                          [1]/id"/>
			 </abstract>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="destination" mode="passone">
		<xsl:copy>
			<xsl:apply-templates mode="passone"/>
			 <abstract>
			   <xsl:value-of select="(key('Enclosure',id)/ancestor-or-self::enclosure 
			                         except key('Enclosure',../source/id)/ancestor-or-self::enclosure)
			                          [1]/id"/>
			 </abstract>
		</xsl:copy>
	</xsl:template>

</xsl:transform>