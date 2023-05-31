/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname 
   FROM 
       u 
   WHERE 
       SUBSTRING(firstname, 0, 1) >= 'm';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.csv' USING PigStorage(',')
        AS(col1:INT,
            col2:charArray,
            col3:charArray,
            col4:charArray,
            col5:charArray,
            col6:INT);

data = FOREACH data GENERATE col2;
data_filtered = FILTER data BY SUBSTRING(col2,0,1) MATCHES '[M-Z]';

STORE data_filtered INTO 'output' USING PigStorage(',');