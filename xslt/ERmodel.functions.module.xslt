<!--
*************************************
ERmodel.functions.module.xslt
*************************************

DESCRIPTION
  user defined functions for use from other xslts.

CHANGE HISTORY

CR18720 JC  16-Nov-2016 Created
-->
<xsl:transform version="2.0" 
        xmlns="http://www.entitymodelling.org/ERmodel"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:era="http://www.entitymodelling.org/ERmodel"
        xmlns:diagram="http://www.entitymodelling.org/diagram" 
        xmlns:math="http://www.w3.org/2005/xpath-functions/math"
        xmlns:erafn="http://www.entitymodelling.org/ERmodel/functions"
        xpath-default-namespace="http://www.entitymodelling.org/ERmodel">

<!-- Construct a composite key value from individual key values -->
<xsl:function 
     name="era:packArray">
    <xsl:param name="parts" as="xs:string*"/>
    <xsl:value-of select="string-join($parts,':')"/>
</xsl:function>

<xsl:function 
    name="era:packArrayOfNonEmpties">
    <xsl:param name="elements" as="xs:string*"/>
    <xsl:variable name="nonempty_elements" as="xs:string*">
         <xsl:for-each select="$elements">
            <xsl:if test=".!=''">
               <xsl:value-of select="."/>
            </xsl:if>
         </xsl:for-each>
    </xsl:variable>
    <xsl:value-of select="string-join($nonempty_elements,':')"/>
</xsl:function>

<!-- Unpack a packed array -->
<xsl:function 
    name="era:unpackArray">
    <xsl:param name="parray" as="xs:string"/>
    <xsl:sequence select="tokenize($parray,':')"/>
</xsl:function>

<!-- Prefix every element of a packed array -->
<xsl:function 
    name="era:prefixPackedArray">
    <xsl:param name="parray" as="xs:string"/>
    <xsl:param name="prefix" as="xs:string"/>

    <xsl:variable name="elements" as="xs:string*" 
                       select="era:unpackArray($parray)"/>
    <xsl:variable name="prefixedelements" as="xs:string*">
         <xsl:for-each select="$elements">
            <xsl:value-of select="concat($prefix,.)"/>
         </xsl:for-each>
    </xsl:variable>
    <xsl:value-of select="era:packArray($prefixedelements)"/>
</xsl:function>

<!-- tan function given argument in degrees -->
<xsl:function 
     name="diagram:tan">
    <xsl:param name="degrees" as="xs:float"/>
    <xsl:value-of select="math:tan($degrees div 180 * math:pi())"/>
</xsl:function>

<!-- cotan function given argument in degrees -->
<xsl:function 
     name="diagram:cotan">
    <xsl:param name="degrees" as="xs:float"/>
    <xsl:value-of select="1 div math:tan($degrees div 180 * math:pi())"/>
</xsl:function>


</xsl:transform>

