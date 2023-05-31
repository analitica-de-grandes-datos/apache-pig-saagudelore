/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.csv' USING PigStorage(',')
        AS (col1:int,
        col2:chararray,
        col3:chararray,
        col4:chararray,
        col5:chararray,
        col6:int); 

data = FOREACH data GENERATE SUBSTRING(col4,0,4) as year;
data_grouped = GROUP data by year; 
data_preocesed = FOREACH data_grouped GENERATE group, COUNT(data);

STORE data_preocesed INTO 'output/' USING PigStorage(',');