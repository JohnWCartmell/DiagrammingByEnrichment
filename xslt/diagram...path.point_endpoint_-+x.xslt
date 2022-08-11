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


	<!-- ******************************************* -->
	<!-- route/path/point[endpoint] +x  -->
	<!-- ******************************************* -->

	<!-- destination is top_edge -->
	<xsl:template match="route
                       [destination/top_edge/deltax]  
					   /path/point[endpoint]
					   [not(x)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
				<x> 
					<at>
						<offset><xsl:value-of select="../../destination/top_edge/deltax"/></offset>
						<of><xsl:value-of select="../../destination/id"/></of>					
					</at>
				</x>
			 <xsl:apply-templates mode="recursive_diagram_enrichment"/>
		</xsl:copy>
	</xsl:template>

	<!-- destination is bottom_edge -->
	<xsl:template match="route
                       [destination/bottom_edge/deltax] 
					   /path/point[startpoint]
					   [not(x)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
				<x> 
					<at>
						<offset><xsl:value-of select="../../destination/bottom_edge/deltax"/></offset>
						<of><xsl:value-of select="../../destination/id"/></of>					
					</at>
				</x>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
		</xsl:copy>
	</xsl:template>

</xsl:transform>

