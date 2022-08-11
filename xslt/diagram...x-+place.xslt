<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform version="2.0" 
               xmlns="http://www.entitymodelling.org/diagram"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:diagram="http://www.entitymodelling.org/diagram" 
               xpath-default-namespace="http://www.entitymodelling.org/diagram">

  <!--  
****************************************
diagram....x.place.xslt
****************************************

DESCRIPTION
  Rules for generating place for x and y.
  Note some rules in diagram.label.x.xslt also generate 'place'. 

CHANGE HISTORY
        JC  26-May-2017 Created as addressing smarts.
        JC  24-Jul-2019 Modified to processed template for x and y.
        JC  23-Aug-2019 Rules for 'place' moved into  'place' separate file
                        includes recent rules for route endpoint labels.
						Make rules other than endpoints more specific.
	    JC 9-Sept2019   Rules for endpoint removed aslabels now subordinate to endpoints.
 -->

  <xsl:output method="xml" indent="yes"/>

  
  <!-- Add defaults for x/place/anchor                               -->
  <!-- x/at/right of X                      -  place/left          -->
  <!-- x/at/left  of X                      -  place/left          -->  <!-- modifed 29 July 2019 -->
  <!-- x/at/right (of containing enclosure) -  place/right         -->
  <!-- x/at/left  (of containing enclosure) -  place/left          -->
  <!-- x/at/centre                          -  place/centre        -->
  <!-- x/at/x                               -  place/left          -->
  
  <xsl:template match="*[not(self::point)]
						/x[not(place)]
                        [at/right] 
                        [at/(of|predecessor)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="199">
    <xsl:copy>
      <place>
         <left/>
      </place>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*[not(self::point)]
                        /x[not(place)]
                        [at/left] 
                        [at/(of|predecessor) ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="199">
    <xsl:copy>
      <place>
         <left/> <!-- modified 29th July 2019 -->
      </place>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[not(self::point)]
                        /x[not(place)]
                        [at/right] 
                        [at/parent]
                    " 
              mode="recursive_diagram_enrichment"
              priority="199">
    <xsl:copy>
      <place>
         <right/><outer/>
      </place>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*[not(self::point)]
                        /x[not(place)]
                        [at/left] 
                        [at/parent]
                    " 
              mode="recursive_diagram_enrichment"
              priority="199">
    <xsl:copy>
      <place>
         <left/><outer/>
      </place>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>

    
  <xsl:template match="*[not(self::point)]
                         /x[not(place)]
                        [at/centre] 
                    " 
              mode="recursive_diagram_enrichment"
              priority="199">
    <xsl:copy>
      <place>
         <centre/><edge/>
      </place>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
    
  <xsl:template match="enclosure/x[not(place)]
                                  [at/x] 
                    " 
              mode="recursive_diagram_enrichment"
              priority="199">
    <xsl:copy>
      <place>
         <left/><edge/>
      </place>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>


</xsl:transform>

