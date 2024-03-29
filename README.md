# README #

An xml-based diagramming system[^1]. 

## Concept
Diagrams may be described in xml and generated into one or both of svg, for use on the web, or latex for inclusion in pdf documents. 
The layout of a diagram -- the positioning of the boxes and the routing of connections between them -- may be specified directly in x,y coordinates or may be specified in broad terms such as by directing, for example, that such and such a box  be positioned alongside of or above or below some other box. Boxes which may be required to have other boxes nested within them are referred to as enclosures. Enclosures may have margins and padding specified for them. Enclosures may be allowed to self size to their contents or may have height h and/or width w specified for them. 
## Requirements
* support user diagramming using browser-side xslt
	* implement incremental evaluation of relationships and attributes[^2]. 
* enable an editable ER-style diagram to be generated automatically from a diagram-free description in xml of entities, relationships and attributes.
The idea is that xslt is used to generate a first-cut diagram in xml. The user is then able to add 
a small number of diagramming directives to the source xml to refine the layout of the generated xml diagram.
 
![introduction](images/x.dimensions.trimmed.svg)

## Source
### Folder diagramModelasERv1.4
Contains the current model of diagrams as an instance of ERmodelv1.4.

### Folder diagramenrichment
Contains xslt transformations for
* completion of an instance of the diagram model
  * in future this xslt will be re-sourced in pure entity logic
* rendering of a complete instance of a diagram model in svg 


## Outstanding
1. Support for end arrows and crowsfeet.
2. Support for conduits.
3. Re-engineer existing enrichment rules in xslt rules back into EntityLogic derived structure, relationships and attributes.
   * generate priorities on xslt templates so as to get rid of duplicate rule warnings
   * generate identity atributes on xslt templates 
   * generate traceability attributes into generated structure.

[^1]: Moved from BitBucket to GitHub 17 August 2021 
[^2]: This is so as to minimise recomputation in response to edits made by the user. This technique is one found in incremental attribute grammars used in syntax directed editing systems. 
