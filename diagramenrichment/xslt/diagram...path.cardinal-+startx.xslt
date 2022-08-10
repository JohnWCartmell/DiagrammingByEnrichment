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

  

  <!-- path/ramp
          startx => midx - deltax div 2
  -->
  <xsl:template match="path/ramp[not(startx)]
                               [deltax]
                               [point/x/relative/*[1][self::offset]]
                    "
                                  mode="recursive_diagram_enrichment"

                                  priority="59">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <startx>
        <xsl:value-of select="point/x/relative/*[1][self::offset] - (deltax div 2)"/>
      </startx>
    </xsl:copy>
  </xsl:template>
  
    <!-- path/ew
          startx => endx - deltax
  -->
  <xsl:template match="path/ew
                               [not(startx)]
                               [deltax]
                               [endx]
                    "
                                  mode="recursive_diagram_enrichment"
                                  priority="59">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <startx>
        <xsl:value-of select="endx - deltax"/>
      </startx>
    </xsl:copy>
  </xsl:template>
  

   <!-- path/(ew | ramp) 
          startx => previous point/x
    -->
  <xsl:template match="path/*[self::ew|self::ramp]
                               [not(startx)]
                               [preceding-sibling::*[1][self::point]/x/relative/*[1][self::offset]]
                    "
                                  mode="recursive_diagram_enrichment"

                                  priority="60">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <startx>
        <xsl:value-of select="preceding-sibling::*[1][self::point]/x/relative/*[1][self::offset]"/>
      </startx>
    </xsl:copy>
  </xsl:template>

</xsl:transform>

