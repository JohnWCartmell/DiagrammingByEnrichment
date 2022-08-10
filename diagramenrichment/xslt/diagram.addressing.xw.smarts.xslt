<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform version="2.0" 
               xmlns="http://www.entitymodelling.org/diagram"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:diagram="http://www.entitymodelling.org/diagram" 
               xpath-default-namespace="http://www.entitymodelling.org/diagram">

  <!--  
****************************************
diagram.addressing.xw.smarts.module.xslt
****************************************

DESCRIPTION
  This xslt contains rules to implement diagram
  x and w structure from higher level directives
  to position enclosures wrt other enclosures
  It is a template with vbls x, w etc so that by substitution, See readme.


CHANGE HISTORY
        JC  26-May-2017 Created. 
		JC  24-Jul-2019 Modified to template.

 -->

  <xsl:output method="xml" indent="yes"/>

  <!-- ********************************** -->
  <!-- x/at/src_rise -->
  <!-- x/at/dest_rise -->

  <xsl:template match="x/at[not(src_rise)]
                           [../../depth]
                           [key('box',of)/depth]
                    " 
              mode="recursive_diagram_enrichment"
              priority="169"
              >
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <src_rise>
        <xsl:value-of select="../../depth - 
                                (  ancestor::*
                                      intersect
                                   (key('box',of)/ancestor::*)
                                )[not(self::route)][last()]/depth
                                      "/>
      </src_rise>
      <dest_rise>
        <xsl:value-of select="key('box',of)/depth - 
                                (  ancestor::*
                                      intersect
                                   (key('box',of)/ancestor::*)
                                ) [not(self::route|self::path)][last()]/depth
                                      "/>  <!-- added self::side now removed -->
      </dest_rise>
    </xsl:copy>
  </xsl:template>

  <!-- Add defaults for relative of an at  -->
  <!-- if no preceding boxes then parent   -->  <!-- NEED complete the enumeration of the box types -->
  <!-- else predecessor                    -->
  <xsl:template match="*[self::enclosure|self::label]/x/at[not(of|parent|predecessor)]
                                     [not(preceding-sibling::enclosure|preceding-sibling::label)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <parent/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[self::enclosure|self::label]/x/at[not(of|parent|predecessor)]
                                     [preceding-sibling::enclosure|preceding-sibling::label]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <predecessor/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Add defaults for at anchor -->  <!-- new rule 29 July 2019 -->
  <!-- x/at          - left   -->
    <xsl:template match="*/x/at[not(left | right | centre | x)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
       <left/>
       <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  

  <!-- Add defaults for at aspect                      -->
  <!-- enclosure/x[place[left]/at/left    - edge    --> 
  <!-- enclosure/x[place[left]/at/right   - outer   --> 
  <!-- enclosure/x[place[right]/at/left   - outer   --> 
  <!-- enclosure/x[place[right]/at/right  - edge    -->  
  <!-- x/at/(centre|x)                    - edge    -->
  
  <!-- 17 June 2019 modifed precondition for outer from [of] to [of|predecessor] -->
  
  <xsl:template match="*
                        [not(self::label and (parent::point/startpoint or parent::point/endpoint))] 
                        /x[place/left]/at[not(margin|edge|outer)]
                                     [left]
                                     [of|predecessor]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
   <xsl:template match="*
                        [not(self::label and (parent::point/startpoint or parent::point/endpoint))] 
                        /x[place/left]/at[not(margin|edge|outer)]
                                     [right]
                                     [of|predecessor]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
         <outer/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
    <xsl:template match="*
                         [not(self::label and (parent::point/startpoint or parent::point/endpoint))] 
                         /x[place/right]/at[not(margin|edge|outer)]
                                     [left]
                                     [of|predecessor]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
         <outer/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
   <xsl:template match="*
                        [not(self::label and (parent::point/startpoint or parent::point/endpoint))] 
                        /x[place/right]/at[not(margin|edge|outer)]
                                     [right]
                                     [of|predecessor]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
 
  
  <xsl:template match="*
                        [not(self::label and (parent::point/startpoint or parent::point/endpoint))] 
                        /x/at[not(margin|edge|outer)]
                                    [centre]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*
                        [not(self::label and (parent::point/startpoint or parent::point/endpoint))] 
                        /x/at[not(margin|edge|outer)]
                                     [right|left]
                                     [parent]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
         <margin/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  
    <xsl:template match="*
                        [not(self::label and (parent::point/startpoint or parent::point/endpoint))] 
                        /x/at[not(margin|edge|outer)]
                                       [x]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>

  
  <!-- Add defaults for place    aspect               -->
  <!-- enclosure/x[at/right]/place/(left)   - outer   -->  <!-- modifed 29th July 2019 -->
  <!-- enclosure/x[at/right]/place/(right)  - edge   -->  <!-- modifed 29th July 2019 -->
  <!-- enclosure/x[at/left]/place/(left)    - edge   -->  <!-- modifed 29th July 2019 -->
  <!-- enclosure/x[at/left]/place/(right)   - outer   -->  <!-- modifed 29th July 2019 -->
  <!-- ABOVE 4 rules USED TO BE 1 rule LESS SPECIFIC enclosure/x/place/(right|left)       - outer   -->
  <!-- not(enclosure)/x/place/(right|left)  - edge   -->
  <!-- x/place/(centre|x)                   - edge    -->
  
  <xsl:template match="enclosure/x[at/right]/place[not(margin|edge|outer)]
                                          [left]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
         <outer/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="enclosure/x[at/right]/place[not(margin|edge|outer)]
                                        [right]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
   <xsl:template match="enclosure/x[at/left]/place[not(margin|edge|outer)]
                                          [left]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="enclosure/x[at/left]/place[not(margin|edge|outer)]
                                        [right]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
         <outer/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  
  <xsl:template match="enclosure/x/place[not(margin|edge|outer)]
                                        [centre]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="enclosure/x/place[not(margin|edge|outer)]
                                        [x]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>


  <xsl:template match="*[not(self::enclosure)]/x/place[not(margin|edge|outer)]
                                                      [left|centre|right|x]
                    " 
              mode="recursive_diagram_enrichment"
              priority="170">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  
 
  
      
  <!-- Rules for effective_ratio attribute of xanchor -->
  <!-- where xanchor ::= left | centre | right | x(3) -->
  <xsl:template match="left[not(effective_ratio)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="171">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <effective_ratio>0</effective_ratio>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*[self::at|self::place]/x[not(effective_ratio)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="171">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <effective_ratio><xsl:value-of select="ratio"/></effective_ratio>  <!-- changed from zero 1Aug 2019 -->
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="centre[not(effective_ratio)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="171">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <effective_ratio>0.5</effective_ratio>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="right[not(effective_ratio)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="171">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <effective_ratio>1.0</effective_ratio>
    </xsl:copy>
  </xsl:template>
  
  
  <!-- DERIVATION OF VALUE FOR ATTRIBUTE offset of entity type at(2) -->
  <!-- WAS enclosure/x-->


 <xsl:template match="x/at[not(offset)]
                           [of]
                           [*/effective_ratio]
                           [key('box',of)/padding]
                           [left or key('box',of)/w ]
                           [right or edge or key('box',of)/wl]
                           [left or edge or key('box',of)/wr]
                    " 
              mode="recursive_diagram_enrichment"
              priority="172"
              >
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>

      <offset trace="9">
          <xsl:choose>
             <xsl:when test="left">
                  <xsl:variable name="offset" as="xs:double" select="if (left and outer) then -key('box',of)/(wl + padding) else 0"/>
                  <xsl:value-of select="$offset"/>
             </xsl:when>
             <xsl:otherwise>
                  <xsl:variable name="effective_width"
                                select = "key('box',of)/w 
                                           + (if(outer) 
                                              then (key('box',of)/(wr + padding))
                                              else 0
                                              )"/>
                  <xsl:variable name="offset" as="xs:double"  select="*/effective_ratio 
                                                                     * $effective_width"/>
                  <xsl:value-of select="$offset"/>
             </xsl:otherwise>
          </xsl:choose>
      </offset>      
     </xsl:copy>
  </xsl:template>


 <xsl:template match="x/at[not(offset)]
                           [predecessor]
                           [*/effective_ratio]
                           [../../preceding-sibling::*[self::enclosure|self::label|self::point][1]/padding]
                           [left or ../../preceding-sibling::*[self::enclosure|self::label|self::point][1]/w ]
                           [right or edge or ../../preceding-sibling::*[self::enclosure|self::label|self::point][1]/wl]
                           [left or edge or ../../preceding-sibling::*[self::enclosure|self::label|self::point][1]/wr]
                    " 
              mode="recursive_diagram_enrichment"
              priority="172"
              >
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="8">
          <xsl:choose>
             <xsl:when test="left">
                  <xsl:variable name="offset" as="xs:double"  select="if (left and outer) then -../../preceding-sibling::*[self::enclosure|self::label|self::point][1]/(wl + padding) else 0"/>
                  <xsl:value-of select="$offset"/>
             </xsl:when>
             <xsl:otherwise>
                  <xsl:variable name="effective_width"
                                select = "../../preceding-sibling::*[self::enclosure|self::label|self::point][1]/w 
                                           + (if(outer) 
                                              then ../../preceding-sibling::*[self::enclosure|self::label|self::point][1]/(wr + padding)
                                              else 0
                                              )"/>
                  <xsl:variable name="offset" as="xs:double"  select="*/effective_ratio 
                                              * $effective_width"/>
                      <xsl:value-of select="$offset"/> 
             </xsl:otherwise>
          </xsl:choose>
      </offset>      
     </xsl:copy>
  </xsl:template>

<!-- FRIDAY 25 August 2017 BROKE THIS TEMPLATE AS WITNESSED BY x.cardinalsandtext.samrts and others -->
<!-- problem is that the squiggle (ancestor::enclosure|ancestor::diagram)[1] returns the diagram -->
<!-- need use last() - FIX applied and tested WEDNESDAY 30 August 2017 -->
<!--
     30 August 2017 - Introduced $frameOfReference using xpath existential quantification and xsl variable 
-->
<!-- 30  August 2017 -->
<!-- Previous rule split into 6 rules:
       3  [outer | margin | edge]
     * 2  [left  | (centre | right) ]
-->


  <xsl:template match="x/at[
                            some $frameOfReference in ../../(ancestor::enclosure|ancestor::diagram)[last()]
                            satisfies .
                               [not(offset)]
                               [parent]
                               [outer ]
                               [left]
                               [exists($frameOfReference/(wl + padding))]
                           ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="172"
              >
    <xsl:variable name="frameOfReference" select="../../(ancestor::enclosure|ancestor::diagram)[last()]"/>
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="17LO">
                <xsl:call-template name="float">
                    <xsl:with-param name="value" 
                                    select="-$frameOfReference/(wl + padding)"/>
                </xsl:call-template>
      </offset>      
     </xsl:copy>
  </xsl:template>

    <xsl:template match="x/at[
                            some $frameOfReference in ../../(ancestor::enclosure|ancestor::diagram)[last()]
                            satisfies .
                               [not(offset)]
                               [parent]
                               [margin]
                               [left]
                               [$frameOfReference/margin]
                           ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="172"
              >
    <xsl:variable name="frameOfReference" select="../../(ancestor::enclosure|ancestor::diagram)[last()]"/>
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="17LM">
                <xsl:call-template name="float">
                    <xsl:with-param name="value" 
                                    select="$frameOfReference/margin"/>
                </xsl:call-template>
      </offset>      
     </xsl:copy>
  </xsl:template>

  <xsl:template match="x/at[
                            some $frameOfReference in ../../(ancestor::enclosure|ancestor::diagram)[last()]
                            satisfies .
                               [not(offset)]
                               [parent]
                               [edge]
                               [left]
                           ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="172"
              >
    <xsl:variable name="frameOfReference" select="../../(ancestor::enclosure|ancestor::diagram)[last()]"/>
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="17LE">
           0
      </offset>      
     </xsl:copy>
  </xsl:template>



    <xsl:template match="x/at[
                            some $frameOfReference in ../../(ancestor::enclosure|ancestor::diagram)[last()]
                            satisfies .
                               [not(offset)]
                               [*/effective_ratio]
                               [parent]
                               [outer]
                               [centre | right]
                               [$frameOfReference/w]
                               [exists($frameOfReference/(wr + padding))]
                           ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="172"
              >
    <xsl:variable name="frameOfReference" select="../../(ancestor::enclosure|ancestor::diagram)[last()]"/>
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="17CR">
                  <xsl:variable name="effective_width"
                                as="xs:double"
                                select = "$frameOfReference/w 
                                           + ($frameOfReference/(wr + padding))
                                        "/>
                <xsl:call-template name="float">
                    <xsl:with-param name="value" 
                                   select="*/effective_ratio * $effective_width"/>
                </xsl:call-template>
      </offset>      
     </xsl:copy>
  </xsl:template>

   <xsl:template match="x/at[
                            some $frameOfReference in ../../(ancestor::enclosure|ancestor::diagram)[last()]
                            satisfies .
                               [not(offset)]
                               [*/effective_ratio]
                               [parent]
                               [margin]
                               [centre | right]
                               [$frameOfReference/w]
                               [$frameOfReference/margin]
                           ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="172"
              >
    <xsl:variable name="frameOfReference" select="../../(ancestor::enclosure|ancestor::diagram)[last()]"/>
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="17CR">
                  <xsl:variable name="effective_width"
                                as="xs:double"
                                select = "$frameOfReference/w 
                                           - $frameOfReference/margin 
                                         "/>
                <xsl:call-template name="float">
                    <xsl:with-param name="value" 
                                   select="*/effective_ratio * $effective_width"/>
                </xsl:call-template>
      </offset>      
     </xsl:copy>
  </xsl:template>

   <xsl:template match="x/at[
                            some $frameOfReference in ../../(ancestor::enclosure|ancestor::diagram)[last()]
                            satisfies .
                               [not(offset)]
                               [*/effective_ratio]
                               [parent]
                               [edge]
                               [centre | right]
                               [$frameOfReference/w]
                           ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="172"
              >
    <xsl:variable name="frameOfReference" select="../../(ancestor::enclosure|ancestor::diagram)[last()]"/>
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="17CR">
                  <xsl:variable name="effective_width"
                                as="xs:double"
                                select = "$frameOfReference/w"/>
                <xsl:call-template name="float">
                    <xsl:with-param name="value" 
                                   select="*/effective_ratio * $effective_width"/>
                </xsl:call-template>
      </offset>      
     </xsl:copy>
  </xsl:template>
  
    <!-- DERIVATION OF VALUE FOR ATTRIBUTE place/offset of entity type x -->
    <!-- 30 August 2017 introduce $subject as subject of placement -->
    <!-- 30 August 2017 Split into multiple rules (COME BACK -INSPECTION SHOWS IRREGULARITIES -->
   <xsl:template match="x/place
                        [
                         some $subject in ../..
                         satisfies .
                           [not(offset)]
                           [$subject/padding]
                           [*/effective_ratio]
                           [left]
                           [edge or (not($subject[self::enclosure|self::point]) or $subject/wl)]
                        ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="173"
              >
    <xsl:variable name="subject" select="../.."/> <!-- subject that is being placed -->
    <xsl:variable name="delta_offset"
                  select="if (../delta) then (- ../delta) else 0"/>                
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="10L">
                  <xsl:variable name="offset"  as="xs:double" select="$delta_offset + (if (outer) then -($subject/((if (self::enclosure or self::point) then wl else 0) + padding)) else 0)"/>
                  <xsl:value-of select="$offset"/>
             
      </offset>
     </xsl:copy>
  </xsl:template>

  <xsl:template match="x/place
                        [
                         some $subject in ../..
                         satisfies .
                           [not(offset)]
                           [$subject/padding]
                           [*/effective_ratio]
                           [centre | right]
                           [$subject/w]
                           [right or edge or (not($subject[self::enclosure]) or $subject/wl)]
                           [edge or (not($subject[self::enclosure]) or $subject/wr)]
                        ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="173"
              >
    <xsl:variable name="subject" select="../.."/> <!-- subject that is being placed -->
    <xsl:variable name="delta_offset"
                  select="if (../delta) then (- ../delta) else 0"/>                
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="10">
                  <xsl:variable name="effective_width"
                                select = "$subject/w 
                                           + (if(outer) 
                                              then $subject/((if (self::enclosure) then wr else 0) + padding) 
                                              else 0
                                              )"/>
                  <xsl:variable name="offset" as="xs:double"  select="number($delta_offset
                               + (*/effective_ratio 
                                 * $effective_width))"/>
                  <xsl:value-of select="$offset"/>
      </offset>
     </xsl:copy>
  </xsl:template>

  

  
  <!--  THE MAIN WORK OF DERIVING a suitable relative offset from the SMART placement at-->
  <!-- was enclosure/x-->
 
 <xsl:template match="*[not(self::point)]/x[not(relative/offset)] 
                        [place/offset]
                        [at/offset]
                        [key('box',at/of)
                             /x/relative/*[position()=current()/at/dest_rise]
                                              [self::offset]
                        ]
                      " 
              mode="recursive_diagram_enrichment"
              priority="173">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <relative>  <!--below modifed from child in descendant::enclosure to descendant::* -->
        <xsl:for-each 
                select="../ancestor::enclosure
                         [not(some $child in descendant::*
                              satisfies $child/id = current()/at/of)
                         ]">
                         <xsl:message>Inserted TBD for <xsl:value-of select="concat(name(),' having id ',id)"/></xsl:message>
          <tbd/>
        </xsl:for-each>
        <offset trace="1">
          <xsl:variable name="offset" as="xs:double"  select="key('box',at/of)/x/relative
                                            /*[position()=current()/at/dest_rise][self::offset]
                                + at/offset - place/offset"/>
          <xsl:value-of select="$offset"/>
        </offset>
      </relative> 
    </xsl:copy>
  </xsl:template>

  <!-- for a point is equivalent to place offset = 0 -->
   <xsl:template match="point/x[not(relative/offset)] 
                        [at/offset]
                        [key('box',at/of)
                             /x/relative/*[position()=current()/at/dest_rise]
                                              [self::offset]
                        ]
                      " 
              mode="recursive_diagram_enrichment"
              priority="173">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <relative>
        <xsl:for-each 
                select="../ancestor::enclosure
                         [not(some $child in descendant::enclosure 
                              satisfies $child/id = current()/at/of)
                         ]">
          <tbd/>
        </xsl:for-each>
        <offset trace="2">
          <xsl:variable name="offset" as="xs:double"  select="key('box',at/of)/x/relative
                                            /*[position()=current()/at/dest_rise][self::offset]
                                + at/offset"/>
          <xsl:value-of select="$offset"/>
        </offset>
      </relative> 
    </xsl:copy>
  </xsl:template>


<!-- DID PREVIOUSLY SAY not(self::point) -->
   <xsl:template match="*/x[not(relative/offset)] 
                        [place/offset]
                        [at/offset]
                        [at/predecessor]
                        [../preceding-sibling::*[self::enclosure|self::label|self::point][1]
                             /x/relative/*[1][self::offset]
                        ]
                      " 
              mode="recursive_diagram_enrichment"
              priority="173">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <relative>
        <offset trace="3">
          <xsl:variable name="offset" as="xs:double"  select="../preceding-sibling::*[self::enclosure|self::label|self::point][1]/x/relative
                                            /*[1][self::offset]
                                + at/offset - place/offset"/>
          <xsl:value-of select="$offset"/>
        </offset>
      </relative> 
    </xsl:copy>
  </xsl:template>


<!-- PREVIOUSLY HAD
  <xsl:template match="point/x[not(relative/offset)] 
                        [at/offset]
                        [at/predecessor]
                        [../preceding-sibling::*[self::enclosure|self::label][1]
                             /x/relative/*[1][self::offset]
                        ]
                      " 
              mode="recursive_diagram_enrichment"
              priority="173">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <relative>
        <offset trace="4">
          <xsl:variable name="offset" as="xs:double"  select="../preceding-sibling::*[self::enclosure|self::label][1]/x/relative
                                            /*[1][self::offset]
                                + at/offset"/>
          <xsl:value-of select="$offset"/>
        </offset>
      </relative> 
    </xsl:copy>
  </xsl:template>
  
  -->

   <xsl:template match="*[not(self::point)]/x[not(relative/offset)] 
                        [place/offset]
                        [at/offset]
                        [at/parent]
                        [not(parent::enclosure) or ../wl]
                      " 
              mode="recursive_diagram_enrichment"
              priority="173">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <relative>
        <offset trace="5">
          <!-- CHANGE WEDNESDAY FOR NESTED BOXES
          <xsl:value-of select="at/offset - place/offset + (if (parent::enclosure) then ../wl else 0) + ../padding + ../ancestor::enclosure[1]/margin "/>  
        -->
                               <!-- I question this +wl ditto +margin maybe restructure around here in fact just broke centred label-->
          <xsl:variable name="offset" as="xs:double"  select="at/offset - place/offset"/> 
          <xsl:value-of select="$offset"/>
        </offset>
      </relative> 
    </xsl:copy>
  </xsl:template>

  <xsl:template match="point/x[not(relative/offset)] 
                        [at/offset]
                        [at/parent]
                        [not(parent::enclosure) or ../wl]
                        [../padding]
                      " 
              mode="recursive_diagram_enrichment"
              priority="173">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <relative>
        <offset trace="6">
          <!-- CHANGE WEDNESDAY FOR NESTED BOXES
          <xsl:value-of select="at/offset - place/offset + (if (parent::enclosure) then ../wl else 0) + ../padding + ../ancestor::enclosure[1]/margin "/>  
        -->
                               <!-- I question this +wl ditto +margin maybe restructure around here in fact just broke centred label-->
          <xsl:variable name="offset" as="xs:double"  select="at/offset"/> 
          <xsl:value-of select="$offset"/>
        </offset>
      </relative> 
    </xsl:copy>
  </xsl:template>




  <!--**********-->
  <!-- x/clocal  -->
  <!-- ********* -->
  <!-- This attribute is used in the parents width calculation. 
       It enables centre alignment of a box within its parent enclosure 
       without predjucing the parent's width calculation from relative 
       positions and widths of its children. 
  -->
  <xsl:template match="x
                       [not(clocal)]
                       [at/centre]
                       [at/parent]
                       [../w]
                       "
                mode="recursive_diagram_enrichment"
                priority="173">

    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
  
      <xsl:if test="place">
          <xsl:message>
             Not yet implemented - support for place in this context - see file diagram.addressing.smarts.xslt
          </xsl:message>
      </xsl:if>
      <clocal>
          <xsl:value-of select="-(../w div 2)"/>  <!-- this the right hand end wrt centre of parent. -->
      </clocal>
    </xsl:copy>
  </xsl:template>


  <!--**********-->
  <!-- x/rlocal  -->
  <!-- ********* -->
  <!-- This attribute is used in the parents width calculation. 
       It enables right alignment of a box within its parent enclosure 
       without predjucing the parent's width calculation from relative positions 
       and widths of its children. 
  -->
  <xsl:template match="*[not(self::point)]/x
                       [not(rlocal)]
                       [at/right]
                       [at/parent]
                       [../w]
                       [(place/outer and (not(..[self::enclosure]) or ../wr) and ../padding) or place/edge or (place/margin and ../margin)]
                       [(at/outer and ../ancestor::enclosure[1]/(wl and padding)) 
                          or at/edge or (at/margin and ../ancestor::enclosure[1]/margin)] 
                       "
                mode="recursive_diagram_enrichment"
                priority="173">

                <!-- was ../../ancestor::enclosure[1]/ {wl, padding,margin} -->

    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>

      <rlocal>
          <xsl:value-of 
            select="- ../w
                    + (if(place/outer) then -(../(if (self::enclosure) then wr else 0) + ../padding)
                       else if (place/margin) then ../margin 
                       else 0 
                      )
                   + (if (at/outer) then ../ancestor::enclosure[1]/(wl + padding)
                      else if (at/margin) then (- ../ancestor::enclosure[1]/margin)
                      else 0
                     )"/>  
      </rlocal>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="point/x
                       [not(rlocal)]
                       [at/right]
                       [at/parent]
                       [(at/outer and ../../ancestor::enclosure[1]/(wl and padding)) 
                          or at/edge or (at/margin and ../../ancestor::enclosure[1]/margin)] 
                       "
                mode="recursive_diagram_enrichment"
                priority="173">

    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>

      <rlocal>
          <xsl:value-of 
            select="(if (at/outer) then ../ancestor::enclosure[1]/(wl + padding)
                      else if (at/margin) then (- ../ancestor::enclosure[1]/margin)
                      else 0
                     )"/>  
      </rlocal>
    </xsl:copy>
  </xsl:template>

</xsl:transform>

