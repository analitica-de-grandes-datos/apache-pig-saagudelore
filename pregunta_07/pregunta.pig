/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' AS 
        ( col1:charArray,
          col2:bag{},
          col3:map[]);

final_data = FOREACH data GENERATE col1, SIZE(col2) AS col2, SIZE(col3) AS col3;
sorted_data = ORDER final_data BY col1, col2, col3;

STORE sorted_data INTO 'output' USING PigStorage(',');

-- cleaned_data = FOREACH data GENERATE REPLACE(col1, '{', '');
-- split_data = FOREACH data GENERATE FLATTEN(STRSPLIT(col2, '\t')) AS (col1:chararray, col2:chararray, ...);
-- sorted_data = ORDER limited_data BY driverId, truckId, eventTime;
-- limited_data = LIMIT data 10;
-- grouped_data = GROUP split_data BY letter;
-- count_data = FOREACH grouped_data GENERATE group, COUNT(split_data);
-- data_2 = FOREACH data GENERATE FLATTEN(col2) as letter_2;