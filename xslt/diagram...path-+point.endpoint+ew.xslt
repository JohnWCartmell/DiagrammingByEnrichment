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


	<!-- destination is left_side_P --> <!-- used to include [destination/left_side/deltay] -->
	<xsl:template match="route
					   [destination[left_side]/id]
					   /path
					   [not(point/endpoint)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="41">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<ew><endarm/></ew>
			<point>
				<endpoint/>
				<x>
					<at>
						<left/><edge/>
						<of><xsl:value-of select="../destination/id"/></of>
					</at>
				</x>
				<!--
				<y> 
					<at>
						<offset><xsl:value-of select="../destination/left_side/deltay"/></offset>
						<of><xsl:value-of select="../destination/id"/></of>					
					</at>
				</y>
				-->
				<label/>
			</point>
		</xsl:copy>
	</xsl:template>

	<!-- destination is right_side --> <!-- used to include [destination/right_side/deltay] -->
	<xsl:template match="route
					   [destination[right_side]/id]
					   /path
					   [not(point/endpoint)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="41">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<ew><endarm/></ew>
			<point>
				<endpoint/>
				<x>
					<at>
						<right/><edge/>
						<of><xsl:value-of select="../destination/id"/></of>
					</at>
				</x>
				<!-- 
				<y> 
					<at>
						<offset><xsl:value-of select="../destination/right_side/deltay"/></offset>
						<of><xsl:value-of select="../destination/id"/></of>					
					</at>
				</y>
				-->
				<label/>
			</point>
		</xsl:copy>
	</xsl:template>

</xsl:transform>

