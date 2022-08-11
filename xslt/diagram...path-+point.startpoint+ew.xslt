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

	<!-- source is left_side --> <!-- used to include[source/left_side/deltay]-->
	<xsl:template match="route
					   [source[left_side]/id]
					   /path
					   [not(point/startpoint)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<point>
				<startpoint/>
				<x>
					<at>
						<left/><edge/>
						<of><xsl:value-of select="../source/id"/></of>
					</at>
				</x>
				<!--
				<y> 
					<at>
						<offset><xsl:value-of select="../source/right_side/deltay"/></offset>
						<of><xsl:value-of select="../source/id"/></of>					
					</at>
				</y>
				-->
				<label/>
			</point>
			<ew><startarm/></ew>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
		</xsl:copy>
	</xsl:template>

	<!-- endpoint 1 is rhs --> <!-- used to include  [source/right_side/deltay] -->
	<xsl:template match="route
					   [source[right_side]/id]
					   /path
					   [not(point/startpoint)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<point>
				<startpoint/>
				<x>
					<at>
						<right/><edge/>
						<of><xsl:value-of select="../source/id"/></of>
					</at>
				</x>
				<!--
				<y> 
					<at>
						<offset><xsl:value-of select="../source/right_side/deltay"/></offset>
						<of><xsl:value-of select="../source/id"/></of>					
					</at>
				</y>
				-->
				<label/>
			</point>
			<ew><startarm/></ew>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
		</xsl:copy>
	</xsl:template>




</xsl:transform>

