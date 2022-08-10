<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform version="2.0" 
               xmlns="http://www.entitymodelling.org/diagram"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:diagram="http://www.entitymodelling.org/diagram" 
               xpath-default-namespace="http://www.entitymodelling.org/diagram">

  <!--  
****************************************
diagram....y.place.xslt
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

  
  <!-- Add defaults for y/place/anchor                               -->
  <!-- y/at/bottom of X                      -  place/top          -->
  <!-- y/at/top  of X                      -  place/top          -->  <!-- modifed 29 July 2019 -->
  <!-- y/at/bottom (of containing enclosure) -  place/bottom         -->
  <!-- y/at/top  (of containing enclosure) -  place/top          -->
  <!-- y/at/middle                          -  place/middle        -->
  <!-- y/at/y                               -  place/top          -->
  
  <xsl:template match="*[not(self::point)]
						/y[not(place)]
                        [at/bottom] 
                        [at/(of|predecessor)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="199">
    <xsl:copy>
      <place>
         <top/>
      </place>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*[not(self::point)]
                        /y[not(place)]
                        [at/top] 
                        [at/(of|predecessor) ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="199">
    <xsl:copy>
      <place>
         <top/> <!-- modified 29th July 2019 -->
      </place>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[not(self::point)]
                        /y[not(place)]
                        [at/bottom] 
                        [at/parent]
                    " 
              mode="recursive_diagram_enrichment"
              priority="199">
    <xsl:copy>
      <place>
         <bottom/><outer/>
      </place>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*[not(self::point)]
                        /y[not(place)]
                        [at/top] 
                        [at/parent]
                    " 
              mode="recursive_diagram_enrichment"
              priority="199">
    <xsl:copy>
      <place>
         <top/><outer/>
      </place>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>

    
  <xsl:template match="*[not(self::point)]
                         /y[not(place)]
                        [at/middle] 
                    " 
              mode="recursive_diagram_enrichment"
              priority="199">
    <xsl:copy>
      <place>
         <middle/><edge/>
      </place>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
    
  <xsl:template match="enclosure/y[not(place)]
                                  [at/y] 
                    " 
              mode="recursive_diagram_enrichment"
              priority="199">
    <xsl:copy>
      <place>
         <top/><edge/>
      </place>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>


</xsl:transform>

