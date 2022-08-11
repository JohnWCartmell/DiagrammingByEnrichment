<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform version="2.0" 
               xmlns="http://www.entitymodelling.org/diagram"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:diagram="http://www.entitymodelling.org/diagram" 
               xpath-default-namespace="http://www.entitymodelling.org/diagram">

<!--  Maintenance Box ->
23 September 2021 Introduce calculated attributes x_outer_upper_offset and y_outer_upper_offset and then use                 
                  to then simplify other rules.  Thereby fix a bug in the rule for y.at.offset
				  erroneously uses non-existent attribute wr of label. 
 -->

<xsl:output method="xml" indent="yes"/>

<!-- ********************************* -->
<!-- enclosure  +y_outer_upper_offset -->
<!-- ********************************* -->
<xsl:template match="enclosure
                     [not(y_outer_upper_offset)]
					 [h]
					 [hb]
					 [padding]
                    " mode="recursive_diagram_enrichment"
              priority="48">
   <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <y_outer_upper_offset>
	     <xsl:value-of select="h + hb + padding"/>
      </y_outer_upper_offset>
   </xsl:copy>
</xsl:template>

<!-- *********************************** -->
<!-- point|label  +y_outer_upper_offset -->
<!-- *********************************** -->
<xsl:template match="*[self::point|self::label]
                     [not(y_outer_upper_offset)]
					 [h]
					 [padding]
                    " mode="recursive_diagram_enrichment"
              priority="48">
   <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <y_outer_upper_offset>
	     <xsl:value-of select="h + padding"/>
      </y_outer_upper_offset>
   </xsl:copy>
</xsl:template>

<!-- *************************************** -->
<!-- path|cardinal|  +y_outer_upper_offset  -->
<!-- *************************************** -->
<!-- TO BE DEFINED!!!!!!!!!!!!!!!!!!!!!!!!!  -->
<!-- BAD BAD BAD IDEA!!!!  SODDED UP ROUTE WITH INTERMEDIATE ATTRIBUTES BETWEEN POINTS AND CARDINALSS SOMETHING ROTTEN 
<xsl:template match="*[self::path|self::ns|self::ew|self::ramp]
                     [not(y_outer_upper_offset)]
                    " mode="recursive_diagram_enrichment"
              priority="48">
   <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <y_outer_upper_offset>
	     <TBD/>
      </y_outer_upper_offset>
   </xsl:copy>
</xsl:template>
-->

</xsl:transform>

