
echo prepare 2.1 xslt source

cd ERmodel_v2.1
call build.bat
cd ..

echo use v1.2 to process the 2.1 meta-model to produce documentation of the model in svg
echo            and to produce an rng to schema check against.

cd diagramModelasERv1.2\src
call build.bat
cd ..\..