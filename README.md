# README #

xml-based entity modelling tools.

Stored on Github 17 August 2021 (Moved from BitBucket.)




Goal
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
