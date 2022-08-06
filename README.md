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

#### SubFolder  ERmodel_v2.1/ERmodelxslt
Contains a rudimentary xslt transformations for
* autogeneration of an instance of the diagram model from a diagram-free entity model
  * as at now in August 2022 the input entity model is required to be an instance of ERmodelv1.2 (it is not required to have any diagramming information -- if it has then it should be ignored )
  * I am considering pausing this development so that I can progress the pure entity logic idea and re-source this work using entity logic.
### Way forward
Have a separate EntityLogic repository
* Create this by extracting diagram free parts of ERmodel v1.4.
* For a time the metamodel of ER logic will be described as an instance of ERmodel v1.4. One advantage of this is so that I can have a diagram of this metamodel. 

#### The ERmodel v1.4 meta model
* includes attributes such as xpath_evaluate which are 'filled in' by xslt as part of a build process. Such attributes as these are derived attributes but is not possible to described such attributes in the model. Would like to extend the model to describe such derived attributes.
* already includes derived (constructed) relationships and supports use of constructed relationships in xpath by way of such as the (derived) attribute xpath_evaluate.
* *not check* what assumption such as xpath_evaluate has -- can this derived xpath code be used from xslt? Assume for now it can.
* question: how much work would it be to bootstrap xpath evaluate.
* question: if we do a bootstrap of xpath-evaluate how much freedom do we have in how we use it are we
  * limited to a static enrichment of a model by its derived features, or are we
  * able to include the derivation of attributes and relatuionships in much more comprehensive transformations such as the gemneration of code or of diagrams.  
* we should try and enable 2. for this will not rule out 1. which maybe useful for debugging and for documentation.






     
