/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código en Pig para manipulación de fechas que genere la siguiente 
salcol1a.

   1971-07-08,jul,07,7
   1974-05-23,may,05,5
   1973-04-22,abr,04,4
   1975-01-29,ene,01,1
   1974-07-03,jul,07,7
   1974-10-18,oct,10,10
   1970-10-05,oct,10,10
   1969-02-24,feb,02,2
   1974-10-17,oct,10,10
   1975-02-28,feb,02,2
   1969-12-07,dic,12,12
   1973-12-24,dic,12,12
   1970-08-27,ago,08,8
   1972-12-12,dic,12,12
   1970-07-01,jul,07,7
   1974-02-11,feb,02,2
   1973-04-01,abr,04,4
   1973-04-29,abr,04,4

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

datos = LOAD 'data.csv' USING PigStorage(',')
    AS (col1:int,
        col2:chararray,
        col3:chararray,
        col4:chararray,
        col5:chararray,
        col6:int); 

data_filter_1 = FOREACH datos GENERATE col4, ToDate(col4,'yyyy-MM-dd') as fecha;
data_filter_2 = FOREACH data_filter_1 GENERATE col4, LOWER(ToString(fecha,'MMM')) as mes, SUBSTRING(col4,5,7) as mes1, GetMonth(fecha) as mes2; 
data_filter_3 = FOREACH data_filter_2 GENERATE col4, REPLACE(mes,'apr','abr') as mes, mes1, mes2;  
data_filter_4 = FOREACH data_filter_3 GENERATE col4, REPLACE(mes,'aug','ago') as mes, mes1, mes2; 
data_filter_5 = FOREACH data_filter_4 GENERATE col4, REPLACE(mes,'dec','dic') as mes, mes1, mes2;
data_filter_6 = FOREACH data_filter_5 GENERATE col4, REPLACE(mes,'jan','ene') as mes, mes1, mes2;

STORE data_filter_6 INTO 'output/' USING PigStorage(',');