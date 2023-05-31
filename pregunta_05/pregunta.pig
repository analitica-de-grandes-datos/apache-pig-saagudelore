/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' AS 
        ( col1:charArray,
          col2:bag{},
          col3:map[]);

data = FOREACH data GENERATE FLATTEN(col2) as letter;
grouped_data = GROUP data BY letter;
final_data = FOREACH grouped_data GENERATE group, COUNT(data.letter);

STORE final_data INTO 'output' USING PigStorage(',');

-- cleaned_data = FOREACH data GENERATE REPLACE(col1, '{', '');
-- split_data = FOREACH data GENERATE FLATTEN(STRSPLIT(col2, '\t')) AS (col1:chararray, col2:chararray, ...);
-- sorted_data = ORDER limited_data BY driverId, truckId, eventTime;
-- limited_data = LIMIT data 10;
-- grouped_data = GROUP split_data BY letter;
-- count_data = FOREACH grouped_data GENERATE group, COUNT(split_data);