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
          starty => midy - deltay div 2
  -->
  <xsl:template match="path/ramp[not(starty)]
                               [deltay]
                               [point/y/relative/*[1][self::offset]]
                    "
                                  mode="recursive_diagram_enrichment"

                                  priority="59">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <starty>
        <xsl:value-of select="point/y/relative/*[1][self::offset] - (deltay div 2)"/>
      </starty>
    </xsl:copy>
  </xsl:template>
  
    <!-- path/ns
          starty => endy - deltay
  -->
  <xsl:template match="path/ns
                               [not(starty)]
                               [deltay]
                               [endy]
                    "
                                  mode="recursive_diagram_enrichment"
                                  priority="59">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <starty>
        <xsl:value-of select="endy - deltay"/>
      </starty>
    </xsl:copy>
  </xsl:template>
  

   <!-- path/(ns | ramp) 
          starty => previous point/y
    -->
  <xsl:template match="path/*[self::ns|self::ramp]
                               [not(starty)]
                               [preceding-sibling::*[1][self::point]/y/relative/*[1][self::offset]]
                    "
                                  mode="recursive_diagram_enrichment"

                                  priority="61">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <starty>
        <xsl:value-of select="preceding-sibling::*[1][self::point]/y/relative/*[1][self::offset]"/>
      </starty>
    </xsl:copy>
  </xsl:template>

</xsl:transform>

