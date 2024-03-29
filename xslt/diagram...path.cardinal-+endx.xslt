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
          endx => midx + deltax div 2
   -->
  <xsl:template match="path/ramp
                               [not(endx)]
                               [deltax]
                               [point/x/relative/*[1][self::offset]]
                    "
                                  mode="recursive_diagram_enrichment"

                                  priority="61">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <endx>
        <xsl:value-of select="point/x/relative/*[1] + (deltax div 2)"/>
      </endx>
    </xsl:copy>
  </xsl:template>
  
    <!-- path/ew
          endx => startx + deltax 
   -->
  <xsl:template match="path/ew
                               [not(endx)]
                               [deltax]
                               [startx]
                    "
                                  mode="recursive_diagram_enrichment"
                                  priority="61">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <endx>
        <xsl:value-of select="startx + deltax"/>  
      </endx>
    </xsl:copy>
  </xsl:template>


    <!-- path/(ew | ramp) 
          endx => following point/x
    -->
  <xsl:template match="path/*[self::ew|self::ramp]
                               [not(endx)]
                               [following-sibling::*[1][self::point]/x/relative/*[1][self::offset]]
                    "
                                  mode="recursive_diagram_enrichment"

                                  priority="62">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <endx>
        <xsl:value-of select="following-sibling::*[1][self::point]/x/relative/*[1][self::offset]"/>
      </endx>
    </xsl:copy>
  </xsl:template>

</xsl:transform>

