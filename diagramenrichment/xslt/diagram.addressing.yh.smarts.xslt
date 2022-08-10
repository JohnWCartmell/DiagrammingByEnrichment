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
  y and h structure from higher level directives
  to position enclosures hbt other enclosures
  It is a template with vbls y, h etc so that by substitution, See readme.


CHANGE HISTORY
        JC  26-May-2017 Created. 
		JC  24-Jul-2019 Modified to template.

 -->

  <xsl:output method="xml" indent="yes"/>

  <!-- ********************************** -->
  <!-- y/at/src_rise -->
  <!-- y/at/dest_rise -->

  <xsl:template match="y/at[not(src_rise)]
                           [../../depth]
                           [key('box',of)/depth]
                    " 
              mode="recursive_diagram_enrichment"
              priority="179"
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
  <xsl:template match="*[self::enclosure|self::label]/y/at[not(of|parent|predecessor)]
                                     [not(preceding-sibling::enclosure|preceding-sibling::label)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <parent/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[self::enclosure|self::label]/y/at[not(of|parent|predecessor)]
                                     [preceding-sibling::enclosure|preceding-sibling::label]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <predecessor/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Add defaults for at anchor -->  <!-- new rule 29 July 2019 -->
  <!-- y/at          - left   -->
    <xsl:template match="*/y/at[not(top | bottom | middle | y)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
       <top/>
       <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  

  <!-- Add defaults for at aspect                      -->
  <!-- enclosure/y[place[top]/at/top    - edge    --> 
  <!-- enclosure/y[place[top]/at/bottom   - outer   --> 
  <!-- enclosure/y[place[bottom]/at/top   - outer   --> 
  <!-- enclosure/y[place[bottom]/at/bottom  - edge    -->  
  <!-- y/at/(middle|y)                    - edge    -->
  
  <!-- 17 June 2019 modifed precondition for outer from [of] to [of|predecessor] -->
  
  <xsl:template match="*
                        [not(self::label and (parent::point/startpoint or parent::point/endpoint))] 
                        /y[place/top]/at[not(margin|edge|outer)]
                                     [top]
                                     [of|predecessor]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
   <xsl:template match="*
                        [not(self::label and (parent::point/startpoint or parent::point/endpoint))] 
                        /y[place/top]/at[not(margin|edge|outer)]
                                     [bottom]
                                     [of|predecessor]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
         <outer/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
    <xsl:template match="*
                         [not(self::label and (parent::point/startpoint or parent::point/endpoint))] 
                         /y[place/bottom]/at[not(margin|edge|outer)]
                                     [top]
                                     [of|predecessor]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
         <outer/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
   <xsl:template match="*
                        [not(self::label and (parent::point/startpoint or parent::point/endpoint))] 
                        /y[place/bottom]/at[not(margin|edge|outer)]
                                     [bottom]
                                     [of|predecessor]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
 
  
  <xsl:template match="*
                        [not(self::label and (parent::point/startpoint or parent::point/endpoint))] 
                        /y/at[not(margin|edge|outer)]
                                    [middle]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*
                        [not(self::label and (parent::point/startpoint or parent::point/endpoint))] 
                        /y/at[not(margin|edge|outer)]
                                     [bottom|top]
                                     [parent]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
         <margin/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  
    <xsl:template match="*
                        [not(self::label and (parent::point/startpoint or parent::point/endpoint))] 
                        /y/at[not(margin|edge|outer)]
                                       [y]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>

  
  <!-- Add defaults for place    aspect               -->
  <!-- enclosure/y[at/bottom]/place/(top)   - outer   -->  <!-- modifed 29th July 2019 -->
  <!-- enclosure/y[at/bottom]/place/(bottom)  - edge   -->  <!-- modifed 29th July 2019 -->
  <!-- enclosure/y[at/top]/place/(top)    - edge   -->  <!-- modifed 29th July 2019 -->
  <!-- enclosure/y[at/top]/place/(bottom)   - outer   -->  <!-- modifed 29th July 2019 -->
  <!-- ABOVE 4 rules USED TO BE 1 rule LESS SPECIFIC enclosure/y/place/(bottom|top)       - outer   -->
  <!-- not(enclosure)/y/place/(bottom|top)  - edge   -->
  <!-- y/place/(middle|x)                   - edge    -->
  
  <xsl:template match="enclosure/y[at/bottom]/place[not(margin|edge|outer)]
                                          [top]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
         <outer/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="enclosure/y[at/bottom]/place[not(margin|edge|outer)]
                                        [bottom]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
   <xsl:template match="enclosure/y[at/top]/place[not(margin|edge|outer)]
                                          [top]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="enclosure/y[at/top]/place[not(margin|edge|outer)]
                                        [bottom]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
         <outer/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  
  <xsl:template match="enclosure/y/place[not(margin|edge|outer)]
                                        [middle]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="enclosure/y/place[not(margin|edge|outer)]
                                        [y]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>


  <xsl:template match="*[not(self::enclosure)]/y/place[not(margin|edge|outer)]
                                                      [top|middle|bottom|y]
                    " 
              mode="recursive_diagram_enrichment"
              priority="180">
    <xsl:copy>
         <edge/>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
    </xsl:copy>
  </xsl:template>
  
  
 
  
      
  <!-- Rules for effective_ratio attribute of xanchor -->
  <!-- where xanchor ::= top | middle | bottom | y(3) -->
  <xsl:template match="top[not(effective_ratio)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="181">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <effective_ratio>0</effective_ratio>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*[self::at|self::place]/y[not(effective_ratio)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="181">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <effective_ratio><xsl:value-of select="ratio"/></effective_ratio>  <!-- changed from zero 1Aug 2019 -->
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="middle[not(effective_ratio)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="181">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <effective_ratio>0.5</effective_ratio>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="bottom[not(effective_ratio)]
                    " 
              mode="recursive_diagram_enrichment"
              priority="181">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <effective_ratio>1.0</effective_ratio>
    </xsl:copy>
  </xsl:template>
  
  
  <!-- DERIVATION OF VALUE FOR ATTRIBUTE offset of entity type at(2) -->
  <!-- WAS enclosure/y-->


 <xsl:template match="y/at[not(offset)]
                           [of]
                           [*/effective_ratio]
                           [key('box',of)/padding]
                           [top or key('box',of)/h ]
                           [bottom or edge or key('box',of)/ht]
                           [top or edge or key('box',of)/hb]
                    " 
              mode="recursive_diagram_enrichment"
              priority="182"
              >
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>

      <offset trace="9">
          <xsl:choose>
             <xsl:when test="top">
                  <xsl:variable name="offset" as="xs:double" select="if (top and outer) then -key('box',of)/(ht + padding) else 0"/>
                  <xsl:value-of select="$offset"/>
             </xsl:when>
             <xsl:otherwise>
                  <xsl:variable name="effective_width"
                                select = "key('box',of)/h 
                                           + (if(outer) 
                                              then (key('box',of)/(hb + padding))
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


 <xsl:template match="y/at[not(offset)]
                           [predecessor]
                           [*/effective_ratio]
                           [../../preceding-sibling::*[self::enclosure|self::label|self::point][1]/padding]
                           [top or ../../preceding-sibling::*[self::enclosure|self::label|self::point][1]/h ]
                           [bottom or edge or ../../preceding-sibling::*[self::enclosure|self::label|self::point][1]/ht]
                           [top or edge or ../../preceding-sibling::*[self::enclosure|self::label|self::point][1]/hb]
                    " 
              mode="recursive_diagram_enrichment"
              priority="182"
              >
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="8">
          <xsl:choose>
             <xsl:when test="top">
                  <xsl:variable name="offset" as="xs:double"  select="if (top and outer) then -../../preceding-sibling::*[self::enclosure|self::label|self::point][1]/(ht + padding) else 0"/>
                  <xsl:value-of select="$offset"/>
             </xsl:when>
             <xsl:otherwise>
                  <xsl:variable name="effective_width"
                                select = "../../preceding-sibling::*[self::enclosure|self::label|self::point][1]/h 
                                           + (if(outer) 
                                              then ../../preceding-sibling::*[self::enclosure|self::label|self::point][1]/(hb + padding)
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
     * 2  [top  | (middle | bottom) ]
-->


  <xsl:template match="y/at[
                            some $frameOfReference in ../../(ancestor::enclosure|ancestor::diagram)[last()]
                            satisfies .
                               [not(offset)]
                               [parent]
                               [outer ]
                               [top]
                               [exists($frameOfReference/(ht + padding))]
                           ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="182"
              >
    <xsl:variable name="frameOfReference" select="../../(ancestor::enclosure|ancestor::diagram)[last()]"/>
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="17LO">
                <xsl:call-template name="float">
                    <xsl:with-param name="value" 
                                    select="-$frameOfReference/(ht + padding)"/>
                </xsl:call-template>
      </offset>      
     </xsl:copy>
  </xsl:template>

    <xsl:template match="y/at[
                            some $frameOfReference in ../../(ancestor::enclosure|ancestor::diagram)[last()]
                            satisfies .
                               [not(offset)]
                               [parent]
                               [margin]
                               [top]
                               [$frameOfReference/margin]
                           ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="182"
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

  <xsl:template match="y/at[
                            some $frameOfReference in ../../(ancestor::enclosure|ancestor::diagram)[last()]
                            satisfies .
                               [not(offset)]
                               [parent]
                               [edge]
                               [top]
                           ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="182"
              >
    <xsl:variable name="frameOfReference" select="../../(ancestor::enclosure|ancestor::diagram)[last()]"/>
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="17LE">
           0
      </offset>      
     </xsl:copy>
  </xsl:template>



    <xsl:template match="y/at[
                            some $frameOfReference in ../../(ancestor::enclosure|ancestor::diagram)[last()]
                            satisfies .
                               [not(offset)]
                               [*/effective_ratio]
                               [parent]
                               [outer]
                               [middle | bottom]
                               [$frameOfReference/h]
                               [exists($frameOfReference/(hb + padding))]
                           ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="182"
              >
    <xsl:variable name="frameOfReference" select="../../(ancestor::enclosure|ancestor::diagram)[last()]"/>
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="17CR">
                  <xsl:variable name="effective_width"
                                as="xs:double"
                                select = "$frameOfReference/h 
                                           + ($frameOfReference/(hb + padding))
                                        "/>
                <xsl:call-template name="float">
                    <xsl:with-param name="value" 
                                   select="*/effective_ratio * $effective_width"/>
                </xsl:call-template>
      </offset>      
     </xsl:copy>
  </xsl:template>

   <xsl:template match="y/at[
                            some $frameOfReference in ../../(ancestor::enclosure|ancestor::diagram)[last()]
                            satisfies .
                               [not(offset)]
                               [*/effective_ratio]
                               [parent]
                               [margin]
                               [middle | bottom]
                               [$frameOfReference/h]
                               [$frameOfReference/margin]
                           ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="182"
              >
    <xsl:variable name="frameOfReference" select="../../(ancestor::enclosure|ancestor::diagram)[last()]"/>
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="17CR">
                  <xsl:variable name="effective_width"
                                as="xs:double"
                                select = "$frameOfReference/h 
                                           - $frameOfReference/margin 
                                         "/>
                <xsl:call-template name="float">
                    <xsl:with-param name="value" 
                                   select="*/effective_ratio * $effective_width"/>
                </xsl:call-template>
      </offset>      
     </xsl:copy>
  </xsl:template>

   <xsl:template match="y/at[
                            some $frameOfReference in ../../(ancestor::enclosure|ancestor::diagram)[last()]
                            satisfies .
                               [not(offset)]
                               [*/effective_ratio]
                               [parent]
                               [edge]
                               [middle | bottom]
                               [$frameOfReference/h]
                           ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="182"
              >
    <xsl:variable name="frameOfReference" select="../../(ancestor::enclosure|ancestor::diagram)[last()]"/>
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="17CR">
                  <xsl:variable name="effective_width"
                                as="xs:double"
                                select = "$frameOfReference/h"/>
                <xsl:call-template name="float">
                    <xsl:with-param name="value" 
                                   select="*/effective_ratio * $effective_width"/>
                </xsl:call-template>
      </offset>      
     </xsl:copy>
  </xsl:template>
  
    <!-- DERIVATION OF VALUE FOR ATTRIBUTE place/offset of entity type y -->
    <!-- 30 August 2017 introduce $subject as subject of placement -->
    <!-- 30 August 2017 Split into multiple rules (COME BACK -INSPECTION SHOWS IRREGULARITIES -->
   <xsl:template match="y/place
                        [
                         some $subject in ../..
                         satisfies .
                           [not(offset)]
                           [$subject/padding]
                           [*/effective_ratio]
                           [top]
                           [edge or (not($subject[self::enclosure|self::point]) or $subject/ht)]
                        ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="183"
              >
    <xsl:variable name="subject" select="../.."/> <!-- subject that is being placed -->
    <xsl:variable name="delta_offset"
                  select="if (../delta) then (- ../delta) else 0"/>                
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="10L">
                  <xsl:variable name="offset"  as="xs:double" select="$delta_offset + (if (outer) then -($subject/((if (self::enclosure or self::point) then ht else 0) + padding)) else 0)"/>
                  <xsl:value-of select="$offset"/>
             
      </offset>
     </xsl:copy>
  </xsl:template>

  <xsl:template match="y/place
                        [
                         some $subject in ../..
                         satisfies .
                           [not(offset)]
                           [$subject/padding]
                           [*/effective_ratio]
                           [middle | bottom]
                           [$subject/h]
                           [bottom or edge or (not($subject[self::enclosure]) or $subject/ht)]
                           [edge or (not($subject[self::enclosure]) or $subject/hb)]
                        ]
                    " 
              mode="recursive_diagram_enrichment"
              priority="183"
              >
    <xsl:variable name="subject" select="../.."/> <!-- subject that is being placed -->
    <xsl:variable name="delta_offset"
                  select="if (../delta) then (- ../delta) else 0"/>                
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <offset trace="10">
                  <xsl:variable name="effective_width"
                                select = "$subject/h 
                                           + (if(outer) 
                                              then $subject/((if (self::enclosure) then hb else 0) + padding) 
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
  <!-- was enclosure/y-->
 
 <xsl:template match="*[not(self::point)]/y[not(relative/offset)] 
                        [place/offset]
                        [at/offset]
                        [key('box',at/of)
                             /y/relative/*[position()=current()/at/dest_rise]
                                              [self::offset]
                        ]
                      " 
              mode="recursive_diagram_enrichment"
              priority="183">
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
          <xsl:variable name="offset" as="xs:double"  select="key('box',at/of)/y/relative
                                            /*[position()=current()/at/dest_rise][self::offset]
                                + at/offset - place/offset"/>
          <xsl:value-of select="$offset"/>
        </offset>
      </relative> 
    </xsl:copy>
  </xsl:template>

  <!-- for a point is equivalent to place offset = 0 -->
   <xsl:template match="point/y[not(relative/offset)] 
                        [at/offset]
                        [key('box',at/of)
                             /y/relative/*[position()=current()/at/dest_rise]
                                              [self::offset]
                        ]
                      " 
              mode="recursive_diagram_enrichment"
              priority="183">
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
          <xsl:variable name="offset" as="xs:double"  select="key('box',at/of)/y/relative
                                            /*[position()=current()/at/dest_rise][self::offset]
                                + at/offset"/>
          <xsl:value-of select="$offset"/>
        </offset>
      </relative> 
    </xsl:copy>
  </xsl:template>


<!-- DID PREVIOUSLY SAY not(self::point) -->
   <xsl:template match="*/y[not(relative/offset)] 
                        [place/offset]
                        [at/offset]
                        [at/predecessor]
                        [../preceding-sibling::*[self::enclosure|self::label|self::point][1]
                             /y/relative/*[1][self::offset]
                        ]
                      " 
              mode="recursive_diagram_enrichment"
              priority="183">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <relative>
        <offset trace="3">
          <xsl:variable name="offset" as="xs:double"  select="../preceding-sibling::*[self::enclosure|self::label|self::point][1]/y/relative
                                            /*[1][self::offset]
                                + at/offset - place/offset"/>
          <xsl:value-of select="$offset"/>
        </offset>
      </relative> 
    </xsl:copy>
  </xsl:template>


<!-- PREVIOUSLY HAD
  <xsl:template match="point/y[not(relative/offset)] 
                        [at/offset]
                        [at/predecessor]
                        [../preceding-sibling::*[self::enclosure|self::label][1]
                             /y/relative/*[1][self::offset]
                        ]
                      " 
              mode="recursive_diagram_enrichment"
              priority="183">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <relative>
        <offset trace="4">
          <xsl:variable name="offset" as="xs:double"  select="../preceding-sibling::*[self::enclosure|self::label][1]/y/relative
                                            /*[1][self::offset]
                                + at/offset"/>
          <xsl:value-of select="$offset"/>
        </offset>
      </relative> 
    </xsl:copy>
  </xsl:template>
  
  -->

   <xsl:template match="*[not(self::point)]/y[not(relative/offset)] 
                        [place/offset]
                        [at/offset]
                        [at/parent]
                        [not(parent::enclosure) or ../ht]
                      " 
              mode="recursive_diagram_enrichment"
              priority="183">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <relative>
        <offset trace="5">
          <!-- CHANGE WEDNESDAY FOR NESTED BOXES
          <xsl:value-of select="at/offset - place/offset + (if (parent::enclosure) then ../ht else 0) + ../padding + ../ancestor::enclosure[1]/margin "/>  
        -->
                               <!-- I question this +ht ditto +margin maybe restructure around here in fact just broke middled label-->
          <xsl:variable name="offset" as="xs:double"  select="at/offset - place/offset"/> 
          <xsl:value-of select="$offset"/>
        </offset>
      </relative> 
    </xsl:copy>
  </xsl:template>

  <xsl:template match="point/y[not(relative/offset)] 
                        [at/offset]
                        [at/parent]
                        [not(parent::enclosure) or ../ht]
                        [../padding]
                      " 
              mode="recursive_diagram_enrichment"
              priority="183">
    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
      <relative>
        <offset trace="6">
          <!-- CHANGE WEDNESDAY FOR NESTED BOXES
          <xsl:value-of select="at/offset - place/offset + (if (parent::enclosure) then ../ht else 0) + ../padding + ../ancestor::enclosure[1]/margin "/>  
        -->
                               <!-- I question this +ht ditto +margin maybe restructure around here in fact just broke middled label-->
          <xsl:variable name="offset" as="xs:double"  select="at/offset"/> 
          <xsl:value-of select="$offset"/>
        </offset>
      </relative> 
    </xsl:copy>
  </xsl:template>




  <!--**********-->
  <!-- y/clocal  -->
  <!-- ********* -->
  <!-- This attribute is used in the parents width calculation. 
       It enables middle alignment of a box within its parent enclosure 
       without predjucing the parent's width calculation from relative 
       positions and widths of its children. 
  -->
  <xsl:template match="y
                       [not(clocal)]
                       [at/middle]
                       [at/parent]
                       [../h]
                       "
                mode="recursive_diagram_enrichment"
                priority="183">

    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>
  
      <xsl:if test="place">
          <xsl:message>
             Not yet implemented - support for place in this context - see file diagram.addressing.smarts.xslt
          </xsl:message>
      </xsl:if>
      <clocal>
          <xsl:value-of select="-(../h div 2)"/>  <!-- this the bottom hand end hbt middle of parent. -->
      </clocal>
    </xsl:copy>
  </xsl:template>


  <!--**********-->
  <!-- y/rlocal  -->
  <!-- ********* -->
  <!-- This attribute is used in the parents width calculation. 
       It enables bottom alignment of a box within its parent enclosure 
       without predjucing the parent's width calculation from relative positions 
       and widths of its children. 
  -->
  <xsl:template match="*[not(self::point)]/y
                       [not(rlocal)]
                       [at/bottom]
                       [at/parent]
                       [../h]
                       [(place/outer and (not(..[self::enclosure]) or ../hb) and ../padding) or place/edge or (place/margin and ../margin)]
                       [(at/outer and ../ancestor::enclosure[1]/(ht and padding)) 
                          or at/edge or (at/margin and ../ancestor::enclosure[1]/margin)] 
                       "
                mode="recursive_diagram_enrichment"
                priority="183">

                <!-- was ../../ancestor::enclosure[1]/ {ht, padding,margin} -->

    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>

      <rlocal>
          <xsl:value-of 
            select="- ../h
                    + (if(place/outer) then -(../(if (self::enclosure) then hb else 0) + ../padding)
                       else if (place/margin) then ../margin 
                       else 0 
                      )
                   + (if (at/outer) then ../ancestor::enclosure[1]/(ht + padding)
                      else if (at/margin) then (- ../ancestor::enclosure[1]/margin)
                      else 0
                     )"/>  
      </rlocal>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="point/y
                       [not(rlocal)]
                       [at/bottom]
                       [at/parent]
                       [(at/outer and ../../ancestor::enclosure[1]/(ht and padding)) 
                          or at/edge or (at/margin and ../../ancestor::enclosure[1]/margin)] 
                       "
                mode="recursive_diagram_enrichment"
                priority="183">

    <xsl:copy>
      <xsl:apply-templates mode="recursive_diagram_enrichment"/>

      <rlocal>
          <xsl:value-of 
            select="(if (at/outer) then ../ancestor::enclosure[1]/(ht + padding)
                      else if (at/margin) then (- ../ancestor::enclosure[1]/margin)
                      else 0
                     )"/>  
      </rlocal>
    </xsl:copy>
  </xsl:template>

</xsl:transform>

