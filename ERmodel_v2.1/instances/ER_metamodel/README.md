What is happening here is that we have an entity model in xml in the v1.4 stye.
This has diagram information mixed in with the structural information aboutthe entity model.
We are using the structural information about entity types and relationships, ignoring the diagram information
and attempting to build a diagram in ERmodellingSeries2 format i.e. expressed in terms of enclosures and 
routes.

ERmodelERmodel.xml is our test input.
         ERmodel2.diagram.xslt is the transform used
ERmodelERmodel.diagram.xml is the output.
This output is further elaborated, enriched and turned into svg (see docs folder for final svg output).

AS part of this development I have changed the elaboration, enrichment, svg transforms to require diagrams be
a diagram namespace. None of the other examples are in this namespace therefore I need to change them by
changing source line xmlns="" to xmlns="http://www.entitymodelling.org/diagram".

This is a job for sed or for powerscript or so but might require less thinking just to plod through with sublime text???