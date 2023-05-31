/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       color 
   FROM 
       u 
   WHERE 
       color NOT LIKE 'b%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/

data = LOAD 'data.csv' USING PigStorage(',')
        AS(col1:INT,
            col2:charArray,
            col3:charArray,
            col4:charArray,
            col5:charArray,
            col6:INT);

data = FOREACH data GENERATE col5;
data_filtered = FILTER data BY NOT (SUBSTRING(col5,0,1) MATCHES '[b]');

STORE data_filtered INTO 'output' USING PigStorage(',');