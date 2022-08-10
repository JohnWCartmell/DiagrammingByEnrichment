<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform version="2.0" 
               xmlns="http://www.entitymodelling.org/diagram"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:diagram="http://www.entitymodelling.org/diagram" 
               xpath-default-namespace="http://www.entitymodelling.org/diagram">

<!--  Maintenance Box 
 -->

<xsl:output method="xml" indent="yes"/>

<!-- ************** -->
<!-- encosure  +hb -->
<!-- ************** -->

  <xsl:template match="enclosure
                        [not(hb)]
						[h]
						[every $edge in key('is_endpoint_of',id)[annotation]
                               satisfies $edge/y_upper_bound
                        ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="43">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <hb>
	     <xsl:value-of select="max((key('is_endpoint_of',id)[annotation]/y_upper_bound,
		                            h
		                           )) - h"/>
	  </hb>
    </xsl:copy>
  </xsl:template>
  
<!-- ************** -->
<!-- point  +hb    -->
<!-- ************** -->

  <xsl:template match="point
                        [not(hb)]
						[every $label in label
                               satisfies $label/h  and $label/y/relative/*[1][self::offset]
                        ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="43">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <hb>
	     <xsl:value-of select="max((label/(h + y/relative/offset[1]) ,
		                            0
		                          ))"/>
	  </hb>
    </xsl:copy>
  </xsl:template>

</xsl:transform>

