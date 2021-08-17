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
          deltaxP => endxP - startxP
   -->
  <xsl:template match="path/ramp[not(deltaxP)]
                               [startxP]
                               [endxP]
                    "
                                  mode="recursive_diagram_enrichment"
                                  priority="55P">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <deltaxP>
        <xsl:value-of select="endxP - startxP"/>
      </deltaxP>
    </xsl:copy>
  </xsl:template>

  <!-- path/ramp
          deltax => deltay / tan degrees
  -->
  <xsl:template match="path/ramp[not(deltaxP)]
                               [deltayP]
                               [degrees]
                    "
                                  mode="recursive_diagram_enrichment"
                                  priority="56P">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <deltaxP>
        <xsl:value-of select="deltayP div diagram:tanP(degrees)"/>
      </deltaxP>
    </xsl:copy>
  </xsl:template>

 


</xsl:transform>

