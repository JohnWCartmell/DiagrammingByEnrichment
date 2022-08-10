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



  <!-- **************** -->
  <!-- path/point   =x     -->
  <!-- **************** -->
  <!-- point => x derived from preceding or following ns.x 
                             or from preceding (ew|ramp) endx
                             or from following (ew|ramp) startx
-->
  <xsl:template match="path/point[not(x)]
                                [following-sibling::*[1][self::ns]/point/x]"
                                  mode="recursive_diagram_enrichment"
                                  priority="55">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <xsl:copy-of select="following-sibling::*[1][self::ns]/point/x"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="path/point[not(x)]
                                [preceding-sibling::*[1][self::ns]/point/x]"
                                  mode="recursive_diagram_enrichment"                              
                                  priority="56">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <xsl:copy-of select="preceding-sibling::*[1][self::ns]/point/x"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="path/point[not(x)]
                                [following-sibling::*[1][self::ew|self::ramp]/startx]"
                                  mode="recursive_diagram_enrichment"
                                  priority="55">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <x>
        <relative>
          <offset>
            <xsl:value-of select="following-sibling::*[1][self::ew|self::ramp]/startx"/>
          </offset>
        </relative>
      </x>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="path/point[not(x)]
                                [preceding-sibling::*[1][self::ew|self::ramp]/endx]"
                                  mode="recursive_diagram_enrichment"
                                  priority="56">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <x>
        <relative>
          <offset>
            <xsl:value-of select="preceding-sibling::*[1][self::ew|self::ramp]/endx"/>
          </offset>
        </relative>
      </x>
    </xsl:copy>
  </xsl:template>
  
  

  <!-- ********** -->
  <!-- path/ns +x -->
  <!-- ********** -->
  
  <xsl:template match="path/ns
                               [preceding-sibling::*[1][self::point]/x]
							   /point[not(x)]
                      "
                                  mode="recursive_diagram_enrichment"
                                  priority="55">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
        <xsl:copy-of select="../preceding-sibling::*[1][self::point]/x"/>
    </xsl:copy>
  </xsl:template>

   <xsl:template match="path/ns
                               [following-sibling::*[1][self::point]/x]
							   /point[not(x)]
                      "
                                  mode="recursive_diagram_enrichment"
                                  priority="56">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
        <xsl:copy-of select="../following-sibling::*[1][self::point]/x"/>
    </xsl:copy>
  </xsl:template>


</xsl:transform>

