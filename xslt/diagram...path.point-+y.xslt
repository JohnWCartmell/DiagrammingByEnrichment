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
  <!-- path/point   =y     -->
  <!-- **************** -->
  <!-- point => y derived from preceding or following ew.y 
                             or from preceding (eh|ramp) endy
                             or from following (eh|ramp) starty
-->
  <xsl:template match="path/point[not(y)]
                                [following-sibling::*[1][self::ew]/point/y]"
                                  mode="recursive_diagram_enrichment"
                                  priority="55">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <xsl:copy-of select="following-sibling::*[1][self::ew]/point/y"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="path/point[not(y)]
                                [preceding-sibling::*[1][self::ew]/point/y]"
                                  mode="recursive_diagram_enrichment"                              
                                  priority="56">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <xsl:copy-of select="preceding-sibling::*[1][self::ew]/point/y"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="path/point[not(y)]
                                [following-sibling::*[1][self::ns|self::ramp]/starty]"
                                  mode="recursive_diagram_enrichment"
                                  priority="55">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <y>
        <relative>
          <offset>
            <xsl:value-of select="following-sibling::*[1][self::ns|self::ramp]/starty"/>
          </offset>
        </relative>
      </y>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="path/point[not(y)]
                                [preceding-sibling::*[1][self::ns|self::ramp]/endy]"
                                  mode="recursive_diagram_enrichment"
                                  priority="56">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <y>
        <relative>
          <offset>
            <xsl:value-of select="preceding-sibling::*[1][self::ns|self::ramp]/endy"/>
          </offset>
        </relative>
      </y>
    </xsl:copy>
  </xsl:template>
  
  

  <!-- ********** -->
  <!-- path/ew +y -->
  <!-- ********** -->
  
  <xsl:template match="path/ew
                               [preceding-sibling::*[1][self::point]/y]
							   /point[not(y)]
                      "
                                  mode="recursive_diagram_enrichment"
                                  priority="55">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
        <xsl:copy-of select="../preceding-sibling::*[1][self::point]/y"/>
    </xsl:copy>
  </xsl:template>

   <xsl:template match="path/ew
                               [following-sibling::*[1][self::point]/y]
							   /point[not(y)]
                      "
                                  mode="recursive_diagram_enrichment"
                                  priority="56">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
        <xsl:copy-of select="../following-sibling::*[1][self::point]/y"/>
    </xsl:copy>
  </xsl:template>


</xsl:transform>

