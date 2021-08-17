
set filename=%1
set filenamebase=%filename:~0,-4%

call %~dp0\set_path_variables

java -jar %SAXON_PATH%\saxon9he.jar -s:%filenamebase%.xml -xsl:%DIAGRAM_GENERATORS%/ERmodel2.diagram.xslt -o:%filenamebase%.diagram.xml 
