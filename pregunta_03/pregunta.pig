/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' USING PigStorage('\t')
     AS(letter:CHARARRAY,
     date:CHARARRAY,
     value:INT);

sorted_data = ORDER data BY value;
limited_data = LIMIT sorted_data 5;
-- grouped_data = GROUP split_data BY letter;
-- count_data = FOREACH grouped_data GENERATE group, COUNT(split_data);

final_data = FOREACH limited_data GENERATE value;

STORE final_data INTO 'output' USING PigStorage(',');