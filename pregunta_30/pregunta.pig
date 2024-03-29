/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de dates que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.csv' USING PigStorage(',')
        AS (col1:int,
                col2:chararray,
                col3:chararray,
                col4:chararray,
                col5:chararray,
                col6:int); 

data_filtro_1 = FOREACH data GENERATE col4, ToDate(col4,'yyyy-MM-dd') as date;
data_filtro_2 = FOREACH data_filtro_1 GENERATE col4, SUBSTRING(col4,8,10) as day, GetDay(date) as day2, LOWER(ToString(date,'EEEEE')) as day3; 
data_filtro_3 = FOREACH data_filtro_2 GENERATE col4, day, day2, REPLACE(day3,'monday','lunes') as day3;  
data_filtro_4 = FOREACH data_filtro_3 GENERATE col4, day, day2, REPLACE(day3,'tuesday','martes') as day3;  
data_filtro_5 = FOREACH data_filtro_4 GENERATE col4, day, day2, REPLACE(day3,'wednesday','miercoles') as day3;  
data_filtro_6 = FOREACH data_filtro_5 GENERATE col4, day, day2, REPLACE(day3,'thursday','jueves') as day3;  
data_filtro_7 = FOREACH data_filtro_6 GENERATE col4, day, day2, REPLACE(day3,'friday','viernes') as day3;  
data_filtro_8 = FOREACH data_filtro_7 GENERATE col4, day, day2, REPLACE(day3,'saturday','sabado') as day3;  
data_filtro_9 = FOREACH data_filtro_8 GENERATE col4, day, day2, REPLACE(day3,'sunday','domingo') as day3;  
data_filtro_10 = FOREACH data_filtro_9 GENERATE col4, day, day2, SUBSTRING(day3,0,3), day3;  

STORE data_filtro_10 INTO 'output/' USING PigStorage(',');