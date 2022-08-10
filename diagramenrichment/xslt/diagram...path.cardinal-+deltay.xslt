<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform version="2.0" 
               xmlns="http://www.entitymodelling.org/diagram"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:diagram="http://www.entitymodelling.org/diagram" 
               xmlns:math="http://www.w3.org/2005/xpath-functions/math"
               xpath-default-namespace="http://www.entitymodelling.org/diagram">

  <!--  Maintenance Box 

 -->

  <xsl:output method="xml" indent="yes"/>



  
  <!-- ********** -->
  <!-- path/ramp  -->
  <!-- ********** -->
  <!-- 
          deltay => endy - starty
   -->
  <xsl:template match="path/ramp[not(deltay)]
                               [starty]
                               [endy]
                    "
                                  mode="recursive_diagram_enrichment"
                                  priority="57">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <deltay>
        <xsl:value-of select="endy - starty"/>
      </deltay>
    </xsl:copy>
  </xsl:template>

  <!-- path/ramp
          deltax => deltay / tan degrees
  -->
  <xsl:template match="path/ramp[not(deltay)]
                               [deltax]
                               [degrees]
                    "
                                  mode="recursive_diagram_enrichment"
                                  priority="58">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <deltay>
        <xsl:value-of select="deltax div diagram:cotan(degrees)"/>
      </deltay>
    </xsl:copy>
  </xsl:template>

 


</xsl:transform>

