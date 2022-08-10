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

<!-- *************** -->
<!-- enclosure + wl -->
<!-- *************** -->

  <xsl:template match="enclosure
                        [not(ht)]
						[every $edge in key('is_endpoint_of',id)[annotation]
                               satisfies $edge/y_lower_bound
                        ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="41">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <ht>
	     <xsl:value-of select="- min((key('is_endpoint_of',id)[annotation]/y_lower_bound ,
		                              0
		                             ))"/>
	  </ht>
    </xsl:copy>
  </xsl:template>
  
<!-- *************** -->
<!-- point + ht     -->
<!-- *************** -->

  <xsl:template match="point
                        [not(ht)]
						[every $label in label
                               satisfies $label/y/relative/*[1][self::offset]
                        ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="41">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <ht>
	     <xsl:value-of select="- min((label/y/relative/offset[1] ,
		                            0
		                          ))"/>
	  </ht>
    </xsl:copy>
  </xsl:template>

</xsl:transform>

