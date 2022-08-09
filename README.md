# README #

xml-based entity modelling tools.

Stored on Github 17 August 2021 (Moved from BitBucket.)

### Requirements

* enable diagram-less entity modelling
* optionally enable one or more ER(A) diagrams to present a model or part of a model  
* support automatic generation of an ER diagram from the pure structure of an ER model
	* support user to improve automated presentation
* source xslt transforms as rules represented in xml described by rules entity model
* factor transform logic so that all that can be represented as derivation of entities, relationships and attributes is represented as derivation of entities, relationships and attributes
  * an example of a derived entity would be a foreign key attribute such as currently created in the ERmodel2.physical_enrichment.module.xslt
  * this may be difficult to describe within entity logic 
   * though maybe it can be constructed by pullback which would be quite something wouldn't it?
* support user diagramming using browser-side xslt
	* use incremental retransformation to mimimise computation

### State of play - 6th August 2022
* The current repository is all about the modelling of diagrams.
* The model of a diagram is more general than just entity modelling.
* The model of a diagram is described using ERscript v1.2.

#### Folder diagramModelasERv1.2
Contains a model of the current model of diagrams as an instance of ERmodelv1.2

#### Folder ERmodel_v2.1 
Contains xslt transformations for
* completion of an instance of the diagram model
  * in future this xslt will be re-sourced in pure entity logic
* rendering of a complete instance of a diagram model in svg 
