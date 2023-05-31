/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname,
       color
   FROM 
       u 
   WHERE color = 'blue' AND firstname LIKE 'Z%';

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

data = FILTER data BY (col5 MATCHES 'blue') AND (SUBSTRING(col2,0,1) MATCHES '[Z]');
data_procesed = FOREACH data GENERATE CONCAT(col2, ' ', col5);

STORE data_procesed INTO 'output' USING PigStorage(',');