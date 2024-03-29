/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' AS (line:chararray);
split_data = FOREACH data GENERATE FLATTEN(STRSPLIT(line, '\t')) AS (letter:chararray);

grouped_data = GROUP split_data BY letter;
count_data = FOREACH grouped_data GENERATE group, COUNT(split_data);

STORE count_data INTO 'output' USING PigStorage(',');
