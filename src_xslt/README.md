# README #

Use the top level build.bat in this folder. This creates an xslt folder 
containing the xslt's that are used at run time.

Explanation:
Some source xslt is preprocessed some not.
Source xslt is in three  different folders named 
     presrc       -- xslts that require preprocessing 
	 src          -- xslts for diagram layout and svg generation
	 ERmodelxslt  -- xslts for processing entity models and their diagrams

Each of these folders has a build script which preprocess
 or copy as needs be to produce run time xslt in the folder called 'xslt'.
 
The run time folder 'xslt' is specified in .gitignore so that it is not copied to the repository.

The xslt development cycle requires editing source or presource xslt in one of the three source folders and running 
the local build script to update run time copy in the 'xslt' folder.