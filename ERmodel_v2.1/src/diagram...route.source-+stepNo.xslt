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

<xsl:key name="SourcedAtBottomEdgeOf" match="source[bottom_edge]" use="id"/>

<!-- ************************ -->
<!-- source: +stepNo          -->
<!-- ************************ -->

   <xsl:template match="source
                        [not(stepNo)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="40">
       <xsl:copy>
          <xsl:apply-templates mode="recursive_diagram_enrichment"/>
		  
	      <stepNo> 
		       <!-- sequentially numbering of the sources leaving the bottom edge
			        of an enclosure. Currently ordered by position of the source 
					within the document but in future by the relative x positions
					of the corresponding destination enclosures.
			    -->
		       <xsl:value-of select="count(key('SourcedAtBottomEdgeOf',id)
		                                             [ count(preceding::source)
													     &lt;
													   count(current()/preceding::source)
												     ]
		                                   )"/>
		  </stepNo>
       </xsl:copy>
  </xsl:template>
  
</xsl:transform>