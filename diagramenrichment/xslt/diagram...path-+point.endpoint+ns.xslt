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


	<!-- ******************************** -->
	<!-- route/path    +point/endpoint  -->
	<!-- ******************************** -->


	<!-- destination is left_side_P -->
	<xsl:template match="route
                       [destination/top_edge/deltax]
					   [destination/id]
					   /path
					   [not(point/endpoint)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="41">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<ns><endarm/></ns>
			<point>
				<endpoint/>
				<y>
					<at>
						<top/><edge/>
						<of><xsl:value-of select="../destination/id"/></of>
					</at>
				</y>
				<x> 
					<at>
						<offset><xsl:value-of select="../destination/top_edge/deltax"/></offset>
						<of><xsl:value-of select="../destination/id"/></of>					
					</at>
				</x>
				<label/>
			</point>
		</xsl:copy>
	</xsl:template>

	<!-- destination is bottom_edge -->
	<xsl:template match="route
                       [destination/bottom_edge/deltax]
					   [destination/id]
					   /path
					   [not(point/endpoint)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="41">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<ns><endarm/></ns>
			<point>
				<endpoint/>
				<y>
					<at>
						<bottom/><edge/>
						<of><xsl:value-of select="../destination/id"/></of>
					</at>
				</y>
				<x> 
					<at>
						<offset><xsl:value-of select="../destination/bottom_edge/deltax"/></offset>
						<of><xsl:value-of select="../destination/id"/></of>					
					</at>
				</x>
				<label/>
			</point>
		</xsl:copy>
	</xsl:template>

</xsl:transform>

