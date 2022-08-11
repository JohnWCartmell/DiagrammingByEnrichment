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
	<!-- route/path/point[startpoint] +y  -->
	<!-- ******************************************* -->

	<!-- source is left_side -->
	<xsl:template match="route
                       [source/left_side/deltay]  
					   /path/point[startpoint]
					   [not(y)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
				<y> 
					<at>
						<offset><xsl:value-of select="../../source/left_side/deltay"/></offset>
						<of><xsl:value-of select="../../source/id"/></of>					
					</at>
				</y>
			 <xsl:apply-templates mode="recursive_diagram_enrichment"/>
		</xsl:copy>
	</xsl:template>

	<!-- source is right_side -->
	<xsl:template match="route
                       [source/right_side/deltay] 
					   /path/point[startpoint]
					   [not(y)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
				<y> 
					<at>
						<offset><xsl:value-of select="../../source/right_side/deltay"/></offset>
						<of><xsl:value-of select="../../source/id"/></of>					
					</at>
				</y>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
		</xsl:copy>
	</xsl:template>

</xsl:transform>

