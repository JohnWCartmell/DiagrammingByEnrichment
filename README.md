# README #

An xml-based diagrammming system. Diagrams may be described in xml and generated one or both of  svg, for use on the web, or latex for inclusion in pdf documents. 

Stored on Github 17 August 2021 (Moved from BitBucket.)


#Goal
* support user diagramming using browser-side xslt
	* implement incremental evaluation of relationships and attributes[^1]. 

# State of play - 6th August 2022
* Diagrams are represented as instances of a diagram entity model written in ERScript v1.?. 
* 

# Folder diagramModelasERv1.2
Contains a model of the current model of diagrams as an instance of ERmodelv?.

#### Folder ERmodel_v2.1 
Contains xslt transformations for
* completion of an instance of the diagram model
  * in future this xslt will be re-sourced in pure entity logic
* rendering of a complete instance of a diagram model in svg 
* 
[^1]: This is so as to minimise recomputation in response to edits made by the user. This technique is one found in incremental attribute grammars used in syntax directed editing systems. 
