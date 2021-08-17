# README #

Some xslt is preprocessed some not.
xslt is in three  different folders named 
     presrc 
	 src
	 ERmodelxslt

xslts that require preprocessing are held in folder presrc.

Each of these folders has a build script which preprocess
 or copy as needs be to produce run time xslt in the folder called 'xslt'.

There is a bug at the moment in that the build script in folder 'src' copies itself into the
run time folder 'xslt' which is confusing. 17 August 2021
 
The run time folder 'xslt' is specified in .gitignore so that it is not copied to the repository.