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

<!-- <xsl:key name="SourcedAtBottomEdgeOf" match="source[bottom_edge]" use="id"/> -->

<!-- ************************ -->
<!-- source: +angleToOtherEnd          -->
<!-- ************************ -->

   <xsl:template match="source
                        [not(angleToOtherEnd)]
						[key('Enclosure',id)/x/abs]
						[../destination/key('Enclosure',id)/x/abs]
						[key('Enclosure',id)/y/abs]
						[../destination/key('Enclosure',id)/y/abs]
                    " 
              mode="recursive_diagram_enrichment"
              priority="40">
       <xsl:copy>
          <xsl:apply-templates mode="recursive_diagram_enrichment"/>
		  <thisEndx>
		       <xsl:value-of select="key('Enclosure',id)/x/abs"/>
		  </thisEndx>
		  <thisEndy>
		       <xsl:value-of select="key('Enclosure',id)/y/abs"/>
		  </thisEndy>

	      <otherEndx> 
		       <xsl:value-of select="../destination/key('Enclosure',id)/x/abs"/>
		  </otherEndx>
		  <otherEndy> 
		       <xsl:value-of select="../destination/key('Enclosure',id)/y/abs"/>
		  </otherEndy>
		  <xsl:variable name="xdiff" as="xs:double" 
		                select="../destination/key('Enclosure',id)/x/abs - key('Enclosure',id)/x/abs"/>
		  <xsl:variable name="ydiff" as="xs:double" 
		                select="../destination/key('Enclosure',id)/y/abs - key('Enclosure',id)/y/abs"/>
		  <angleToOtherEnd><xsl:value-of select="diagram:angleToYaxis($xdiff,$ydiff)"/></angleToOtherEnd>
       </xsl:copy>
  </xsl:template>
  
</xsl:transform>