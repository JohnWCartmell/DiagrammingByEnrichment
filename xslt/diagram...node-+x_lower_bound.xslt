<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform version="2.0" 
               xmlns="http://www.entitymodelling.org/diagram"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:diagram="http://www.entitymodelling.org/diagram" 
               xpath-default-namespace="http://www.entitymodelling.org/diagram">

  <!--  
DESCRIPTION
 -->

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="route/source
                       [../path/point[startpoint]/x/at/offset]
                       [../path/point[startpoint]/wl]
                       [not(x_lower_bound)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="199">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
	  <x_lower_bound>
	       <xsl:value-of select="../path/point[startpoint]/(x/at/offset - wl)"/>
	  </x_lower_bound>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="route/destination
                       [../path/point[endpoint]/x/at/offset]
                       [../path/point[endpoint]/wl]
                       [not(x_lower_bound)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="199">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
	  <x_lower_bound>
	       <xsl:value-of select="../path/point[endpoint]/(x/at/offset - wl)"/>
	  </x_lower_bound>
    </xsl:copy>
  </xsl:template>
  
</xsl:transform>

