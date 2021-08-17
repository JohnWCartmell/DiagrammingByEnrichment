

<xsl:transform version="2.0" 
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:math="http://www.w3.org/2005/xpath-functions/math"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"       
		xmlns:xlink="http://www.w3.org/TR/xlink" 
		xmlns:svg="http://www.w3.org/2000/svg" 
		xmlns:diagram="http://www.entitymodelling.org/diagram" 
		xpath-default-namespace="http://www.entitymodelling.org/diagram"
		xmlns="http://www.entitymodelling.org/diagram"
		>

	<xsl:output method="xml" indent="yes" />
	
	<xsl:key name="IncomingTopdownRoute" match="route[top_down]" use="destination/abstract"/>
	<xsl:key name="OutgoingTopdownRoute" match="route[top_down]" use="source/abstract"/>
	<xsl:key name="TerminatingIncomingTopdownRoute" match="route[top_down]" use="destination/id"/>

	<xsl:template match="*" mode="passtwo">
		<xsl:copy>
			<xsl:apply-templates mode="passtwo"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="enclosure[key('IncomingTopdownRoute',id)]" mode="passtwo">
		<xsl:copy>
			<xsl:apply-templates mode="passtwo"/>
			<y> 
				<place>
					<top/>
				</place>
				<at>
					<bottom/>
					<of>
						<xsl:value-of select="key('IncomingTopdownRoute',id)[1]/source/abstract"/>
					</of>
				</at>
			</y>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="enclosure
	                     [not(key('IncomingTopdownRoute',id))]
						 [not(key('TerminatingIncomingTopdownRoute',id))]
	                     [preceding-sibling::enclosure]
	                    " mode="passtwo">
		<xsl:copy>
			<xsl:apply-templates mode="passtwo"/>
			<x> 
				<at>
					<left/>
					<predecessor/>
				</at>
			</x>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="*" mode="passthree">
		<xsl:copy>
			<xsl:apply-templates mode="passthree"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="enclosure/enclosure
						 [key('TerminatingIncomingTopdownRoute',id)]
						 [not(y)]
						 
	                    " mode="passthree">
		<xsl:copy>
			<xsl:apply-templates mode="passthree"/>
			<y> 
				<at>
					<top/>
					<parent/>
				</at>
			</y>
		</xsl:copy>
	</xsl:template>

	
	<xsl:template match="*" mode="passfour">
		<xsl:copy>
			<xsl:apply-templates mode="passfour"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="enclosure
	                     [key('IncomingTopdownRoute',id)]
						 [not(preceding::enclosure
						         [(key('IncomingTopdownRoute',id)[1]/source/abstract)
								   =
								   (key('IncomingTopdownRoute',current()/id)[1]/source/abstract)
								 ]
							  )
					      ]
						   " 
						 mode="passfour">
						 
		<xsl:copy>
			<xsl:apply-templates mode="passfour"/>
			<x> 
				<place>
					<left/>
				</place>
				<at>
					<left/>
					<of>
						<xsl:value-of select="key('IncomingTopdownRoute',id)[1]/source/abstract"/>
					</of>
				</at>
			</x>
		</xsl:copy>
	</xsl:template>


</xsl:transform>