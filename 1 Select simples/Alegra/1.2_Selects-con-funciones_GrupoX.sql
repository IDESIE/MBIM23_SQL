------------------------------------------------------------------------------------------------
-- SELECT CON FUNCIONES
------------------------------------------------------------------------------------------------
/* 1
Mostrar la fecha actual de la siguiente forma:
Fecha actual
------------------------------
Sábado, 11 de febrero de 2027. 16:06:06

El día en palabras con la primera letra en mayúsculas, seguida de una coma, el día en números,
la palabra "de", el mes en minúscula en palabras, la palabra "de", el año en cuatro dígitos
finalizando con un punto. Luego la hora en formato 24h con minutos y segundos.
Y de etiqueta del campo "Fecha actual".
*/
select 
    TO_CHAR(SYSDATE, 'DD "de" Month "de" YYYY. HH24:MI:SS')
    from dual;
/* 2
Día en palabras de cuando se instalaron los componentes
del facility 1
*/
SELECT 
    INITCAP(TO_CHAR(installatedon, 'Day')) AS "Fecha de instalación"
FROM components
WHERE facilityid = 1;
/* 3
De los espacios, obtener la suma de áreas, cuál es el mínimo, el máximo y la media de áreas
del floorid 1. Redondeado a dos dígitos.
*/
select 
    min (netarea),
    max(netarea),
    sum (netarea),
    count (netarea),
    round(avg (netarea),2)
from spaces
where floorid = 1;
/* 4
¿Cuántos componentes tienen espacio? ¿Cuántos componentes hay?
En el facility 1. Ej.
ConEspacio  Componentes
----------------------------
3500  4000
*/
SELECT COUNT(*) AS componentes_con_espacio
FROM components
WHERE spaceid IS NOT NULL;

/* 5
Mostrar tres medias que llamaremos:
-Media a la media del área bruta
-MediaBaja la media entre el área media y el área mínima
-MediaAlta la media entre el área media y el área máxima
de los espacios del floorid 1
Solo la parte entera, sin decimales ni redondeo.
*/
SELECT 
MIN(netarea) AS "Area Mínima"
FROM spaces
WHERE floorid = 1;

SELECT MAX(netarea) AS "Area MÁXIMA"
FROM spaces
WHERE floorid = 1;

SELECT 
FLOOR(AVG(GROSSAREA)) AS "Media",
FLOOR(AVG((AVG(netarea)+MIN(netarea)/2)) AS "MediaBaja",
FLOOR(AVG((AVG(netarea)+MAX(netarea)/2)) AS "MediaAlta"
FROM spaces
WHERE floorid = 1;
/* 6
Cuántos componentes hay, cuántos tienen fecha inicio de garantia, cuántos tienen espacio, y en cuántos espacios hay componentes
en el facility 1.
*/
SELECT COUNT(*) AS total_componentes
FROM components;

SELECT COUNT(*) AS componentes_con_garantia
FROM components
WHERE warrantystarton IS NOT NULL;

SELECT COUNT(*) AS componentes_con_espacio
FROM components
WHERE spaceid IS NOT NULL;

SELECT COUNT(*) AS espacios_con_componentes
FROM COMPONENTS
JOIN spaces ON components.spaceid = SPACES.ID
WHERE FACILITYID = 1;
/* 7
Mostrar cuántos espacios tienen el texto 'Aula' en el nombre
del facility 1.
*/
SELECT COUNT(*) AS espacios_con_nombre_aula
FROM components
WHERE spaceid IS NOT NULL 
    AND FACILITYID=1 
    AND name = '%Aula%';
/* 8
Mostrar el porcentaje de componentes que tienen fecha de inicio de garantía
del facility 1.
*/
select 
    concat (round (count (warrantystarton)/ count(*) *100,2) , '%')
from components
where facilityid = 1;
/* 9
Listar las cuatro primeras letras del nombre de los espacios sin repetir
del facility 1. 
En orden ascendente.
Ejemplo:
Aula
Area
Aseo
Pasi
Pati
Serv
*/
select DISTINCT
    substr(name, 1,4) primeras_cuatro_letras
from spaces
where floorid = 1
order by 1 asc;
/* 10
Número de componentes por fecha de instalación del facility 1
ordenados descendentemente por la fecha de instalación
Ejemplo:
Fecha   Componentes
-------------------
2021-03-23 34
2021-03-03 232
*/
select
    to_char(installatedon, 'yyyy'),
    count(id)
from components
where facilityid = 1
group by to_char (installatedon, 'yyyy')
order by 1 DESC;
/* 11
Un listado por año del número de componentes instalados del facility 1
ordenados descendentemente por año.
Ejemplo
Año Componentes
---------------
2021 344
2020 2938
*/
SELECT 
    to_char(installatedon, 'yyyy') as Año,
    count (id)
FROM components
WHERE facilityid = 1
group BY(installatedon, 'yyyy')
order by 1 DESC;
/* 12
Nombre del día de instalación y número de componentes del facility 1.
ordenado de lunes a domingo
Ejemplo:
Día         Componentes
-----------------------
Lunes    	503
Martes   	471
Miércoles	478
Jueves   	478
Viernes  	468
Sábado   	404
Domingo  	431
*/
SELECT 
    TO_CHAR(installatedon, 'DD') AS Día, 
    COUNT(*) AS Componentes
FROM 
    components
WHERE 
    facilityid = 1
GROUP BY (installatedon, 'DD')
ORDER BY 1 DESC;
/*13
Mostrar en base a los cuatro primeros caracteres del nombre cuántos espacios hay
del floorid 1 ordenados ascendentemente por el nombre.
Ejemplo.
Aula 23
Aseo 12
Pasi 4
*/
SELECT 
    substr(spaces.name, 1,4),
    id as Espacios
FROM spaces
WHERE floorid = 1
order by 1 asc;
/*14
Cuántos componentes de instalaron un Jueves
en el facilityid 1
*/
select
    to_char(installatedon, 'day') as Día,
    count(id) as Componentes
from components
where facilityid = 1
    and trim(to_char(installatedon, 'day')) = 'jueves'
group by to_char(installatedon, 'day');
/*15
Listar el id de planta concatenado con un guión
seguido del id de espacio concatenado con un guión
y seguido del nombre del espacio.
el id del espacio debe tener una longitud de 3 caracteres
Ej. 3-004-Nombre
*/
 select
    floorid || '-' || lpad(id, 3, '0') || '-' || name AS Nombre
from spaces;
------------------------------------------------------------------------------------------------
