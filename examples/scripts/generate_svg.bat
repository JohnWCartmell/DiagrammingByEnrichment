
set filename=%1
set filenamebase=%filename:~0,-4%

call %~dp0\set_path_variables

java -jar %SAXON_PATH%\saxon9he.jar -s:temp/%filenamebase%.enriched.xml -xsl:%DIAGRAM_GENERATORS%/diagram2.svg.xslt -o:docs/%filenamebase%.svg filestem=%filenamebase%
