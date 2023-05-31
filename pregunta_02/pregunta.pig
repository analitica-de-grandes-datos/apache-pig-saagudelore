/*
Pregunta
===========================================================================

Ordene el archivo `data.tsv`  por letra y valor (3ra columna). Escriba el
resultado separado por comas.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

     >>> Escriba el codigo del mapper a partir de este punto <<<
*/

data = LOAD 'data.tsv' USING PigStorage('\t')
     AS(letter:CHARARRAY,
     date:CHARARRAY,
     value:INT);

ordered_data = ORDER data BY letter, value;
-- grouped_data = GROUP split_data BY letter;
-- count_data = FOREACH grouped_data GENERATE group, COUNT(split_data);

STORE ordered_data INTO 'output' USING PigStorage(',');