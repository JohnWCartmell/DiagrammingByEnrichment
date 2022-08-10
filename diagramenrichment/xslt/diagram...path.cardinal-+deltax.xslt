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
          deltax => endx - startx
   -->
  <xsl:template match="path/ramp[not(deltax)]
                               [startx]
                               [endx]
                    "
                                  mode="recursive_diagram_enrichment"
                                  priority="55">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <deltax>
        <xsl:value-of select="endx - startx"/>
      </deltax>
    </xsl:copy>
  </xsl:template>

  <!-- path/ramp
          deltax => deltay / tan degrees
  -->
  <xsl:template match="path/ramp[not(deltax)]
                               [deltay]
                               [degrees]
                    "
                                  mode="recursive_diagram_enrichment"
                                  priority="56">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <deltax>
        <xsl:value-of select="deltay div diagram:tan(degrees)"/>
      </deltax>
    </xsl:copy>
  </xsl:template>

 


</xsl:transform>

