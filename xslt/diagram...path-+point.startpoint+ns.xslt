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
	<!-- route/path    +point/startpoint  -->
	<!-- ******************************** -->

	<!-- source is top_edge --> <!-- used to include[source/top_edge/deltax]-->
	<xsl:template match="route
					   [source[top_edge]/id]
					   /path
					   [not(point/startpoint)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<point>
				<startpoint/>
				<y>
					<at>
						<top/><edge/>
						<of><xsl:value-of select="../source/id"/></of>
					</at>
				</y>
				<!--
				<x> 
					<at>
						<offset><xsl:value-of select="../source/bottom_edge/deltax"/></offset>
						<of><xsl:value-of select="../source/id"/></of>					
					</at>
				</x>
				-->
				<label/>
			</point>
			<ns><startarm/></ns>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
		</xsl:copy>
	</xsl:template>

	<!-- endpoint 1 is rhs --> <!-- used to include  [source/bottom_edge/deltax] -->
	<xsl:template match="route
					   [source[bottom_edge]/id]
					   /path
					   [not(point/startpoint)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<point>
				<startpoint/>
				<y>
					<at>
						<bottom/><edge/>
						<of><xsl:value-of select="../source/id"/></of>
					</at>
				</y>
				<!--
				<x> 
					<at>
						<offset><xsl:value-of select="../source/bottom_edge/deltax"/></offset>
						<of><xsl:value-of select="../source/id"/></of>					
					</at>
				</x>
				-->
				<label/>
			</point>
			<ns><startarm/></ns>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
		</xsl:copy>
	</xsl:template>




</xsl:transform>

