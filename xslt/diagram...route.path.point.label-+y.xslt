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
	<!-- route/path[lhs]/point[startpoint]/label   +y  -->
	<!-- ********************************************** -->

	<!-- source is top_edge -->
	<xsl:template match="route
                       [source/top_edge]
					   /path/point[startpoint]/label
					   [not(y)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<y>
			  <local>
				<xsl:value-of select="-key('endline_style',../../../source/endline_style)/label_long_offset"/>
			  </local>
			</y>
		</xsl:copy>
	</xsl:template>
	
    <!-- source is bottom_edge -->
	<xsl:template match="route
                       [source/bottom_edge]
					   /path/point[startpoint]/label
					   [not(y)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<y>
			  <local>
				<xsl:value-of select="key('endline_style',../../../destination/endline_style)/label_long_offset"/>
			  </local>
			</y>
		</xsl:copy>
	</xsl:template>
	
	<!-- ********************************************** -->
	<!-- route/path/point[endpoint]/label   +y  -->
	<!-- ********************************************** -->

	<!-- destination is top_edge -->
	<xsl:template match="route
                       [destination/top_edge]
					   /path/point[endpoint]/label
					   [h]
					   [not(y)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<y>
			  <local>
				<xsl:value-of select="-h - key('endline_style',../../../source/endline_style)/label_long_offset"/>
			  </local>
			</y>
		</xsl:copy>
	</xsl:template>
	
    <!-- destination is bottom_edge -->
	<xsl:template match="route
                       [destination/bottom_edge]
					   /path/point[endpoint]/label
					   [not(y)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<y>
			  <local>
				<xsl:value-of select="key('endline_style',../../../destination/endline_style)/label_long_offset"/>
			  </local>
			</y>
		</xsl:copy>
	</xsl:template>
	
	
	
	<!-- ******************************** -->
	<!-- path/point[startpoint]   +y  -->
	<!-- ******************************** -->

	<!-- source annotation  is annotate_high-->
	<xsl:template match="route
                       [source/*/annotate_high]
					   /path/point[startpoint]/label[h]
					   [not(y)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<y>
			  <local>
				<xsl:value-of select="-key('endline_style',../../../source/endline_style)/label_lateral_offset
				                      - h"/>
			  </local>
			</y>
		</xsl:copy>
	</xsl:template>
	
		<!-- source annotation is  annotate_low -->
	<xsl:template match="route
                       [source/*/annotate_low]
					   /path/point[startpoint]/label
					   [not(y)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<y>
			  <local>
				<xsl:value-of select="key('endline_style',../../../source/endline_style)/label_lateral_offset"/>
			  </local>
			</y>
		</xsl:copy>
	</xsl:template>
	
		<!-- ******************************** -->
	<!-- path/point[endpoint]   +y  -->
	<!-- ******************************** -->
	
	<!-- destination annotation  is annotate_high-->
	<xsl:template match="route
                       [destination/*/annotate_high]
					   /path/point[endpoint]/label[h]
					   [not(y)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<y>
			  <local>
				<xsl:value-of select="-key('endline_style',../../../destination/endline_style)/label_lateral_offset
				                      - h"/>
			  </local>
			</y>
		</xsl:copy>
	</xsl:template>
	
		<!-- destination annotation is annotate_low-->
	<xsl:template match="route
                       [destination/*/annotate_low]
					   /path/point[endpoint]/label
					   [not(y)]
					   " 
              mode="recursive_diagram_enrichment"
              priority="40">		  
		<xsl:copy>
			<xsl:apply-templates mode="recursive_diagram_enrichment"/>
			<y>
			  <local>
				<xsl:value-of select="key('endline_style',../../../destination/endline_style)/label_lateral_offset"/>
			  </local>
			</y>
		</xsl:copy>
	</xsl:template>
	

</xsl:transform>

