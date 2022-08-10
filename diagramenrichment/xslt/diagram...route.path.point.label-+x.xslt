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


	<!-- ********************************************** -->
	<!-- route/path[lhs]/point[startpoint]/label   +x  -->
	<!-- ********************************************** -->

	<!-- source is left_side -->
	<xsl:template match="route
                       [source/left_side]
					   /path/point[startpoint]/label
					   [not(x)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<x>
			  <local>
				<xsl:value-of select="-key('endline_style',../../../source/endline_style)/label_long_offset"/>
			  </local>
			</x>
		</xsl:copy>
	</xsl:template>
	
    <!-- source is right_side -->
	<xsl:template match="route
                       [source/right_side]
					   /path/point[startpoint]/label
					   [not(x)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<x>
			  <local>
				<xsl:value-of select="key('endline_style',../../../destination/endline_style)/label_long_offset"/>
			  </local>
			</x>
		</xsl:copy>
	</xsl:template>
	
	<!-- ********************************************** -->
	<!-- route/path/point[endpoint]/label   +x  -->
	<!-- ********************************************** -->

	<!-- destination is left_side -->
	<xsl:template match="route
                       [destination/left_side]
					   /path/point[endpoint]/label
					   [w]
					   [not(x)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<x>
			  <local>
				<xsl:value-of select="-w - key('endline_style',../../../source/endline_style)/label_long_offset"/>
			  </local>
			</x>
		</xsl:copy>
	</xsl:template>
	
    <!-- destination is right_side -->
	<xsl:template match="route
                       [destination/right_side]
					   /path/point[endpoint]/label
					   [not(x)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<x>
			  <local>
				<xsl:value-of select="key('endline_style',../../../destination/endline_style)/label_long_offset"/>
			  </local>
			</x>
		</xsl:copy>
	</xsl:template>
	
	
	
	<!-- ******************************** -->
	<!-- path/point[startpoint]   +x  -->
	<!-- ******************************** -->

	<!-- source annotation  is annotate_left-->
	<xsl:template match="route
                       [source/*/annotate_left]
					   /path/point[startpoint]/label[w]
					   [not(x)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<x>
			  <local>
				<xsl:value-of select="-key('endline_style',../../../source/endline_style)/label_lateral_offset
				                      - w"/>
			  </local>
			</x>
		</xsl:copy>
	</xsl:template>
	
		<!-- source annotation is  annotate_right -->
	<xsl:template match="route
                       [source/*/annotate_right]
					   /path/point[startpoint]/label
					   [not(x)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<x>
			  <local>
				<xsl:value-of select="key('endline_style',../../../source/endline_style)/label_lateral_offset"/>
			  </local>
			</x>
		</xsl:copy>
	</xsl:template>
	
		<!-- ******************************** -->
	<!-- path/point[endpoint]   +x  -->
	<!-- ******************************** -->
	
	<!-- destination annotation  is annotate_left-->
	<xsl:template match="route
                       [destination/*/annotate_left]
					   /path/point[endpoint]/label[w]
					   [not(x)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<x>
			  <local>
				<xsl:value-of select="-key('endline_style',../../../destination/endline_style)/label_lateral_offset
				                      - w"/>
			  </local>
			</x>
		</xsl:copy>
	</xsl:template>
	
		<!-- destination annotation is annotate_right-->
	<xsl:template match="route
                       [destination/*/annotate_right]
					   /path/point[endpoint]/label
					   [not(x)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<x>
			  <local>
				<xsl:value-of select="key('endline_style',../../../destination/endline_style)/label_lateral_offset"/>
			  </local>
			</x>
		</xsl:copy>
	</xsl:template>
	

</xsl:transform>

