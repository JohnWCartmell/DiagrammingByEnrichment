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
          endy => midy + deltay div 2
   -->
  <xsl:template match="path/ramp
                               [not(endy)]
                               [deltay]
                               [point/y/relative/*[1][self::offset]]
                    "
                                  mode="recursive_diagram_enrichment"

                                  priority="61">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <endy>
        <xsl:value-of select="point/y/relative/*[1] + (deltay div 2)"/>
      </endy>
    </xsl:copy>
  </xsl:template>
  
    <!-- path/ew
          endx => startx + deltax 
   -->
  <xsl:template match="path/ns
                               [not(endy)]
                               [deltay]
                               [starty]
                    "
                                  mode="recursive_diagram_enrichment"
                                  priority="61">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <endy>
        <xsl:value-of select="starty + deltay"/>  
      </endy>
    </xsl:copy>
  </xsl:template>


    <!-- path/(eh | ramp) 
          endy => following point/y
    -->
  <xsl:template match="path/*[self::ns|self::ramp]
                               [not(endy)]
                               [following-sibling::*[1][self::point]/y/relative/*[1][self::offset]]
                    "
                                  mode="recursive_diagram_enrichment"

                                  priority="62">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <endy>
        <xsl:value-of select="following-sibling::*[1][self::point]/y/relative/*[1][self::offset]"/>
      </endy>
    </xsl:copy>
  </xsl:template>

</xsl:transform>

