/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' AS 
        ( col1:charArray,
          col2:bag{},
          col3:map[]);

data = FOREACH data GENERATE FLATTEN(col2) as c2, FLATTEN(col3) as c3;
grouped_data = GROUP data BY (c2, c3);
final_data = FOREACH grouped_data GENERATE group, COUNT(data);

STORE final_data INTO 'output' USING PigStorage(',');