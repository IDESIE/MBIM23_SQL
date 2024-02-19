------------------------------------------------------------------------------------------------
--SELECTS SIMPLES
------------------------------------------------------------------------------------------------
/* 1
Describir la tabla floors
*/
desc floors;
/* 2
Describir la tabla spaces
*/
desc spaces;
/* 3
Datos de la tabla components
*/
select *
from components;
/* 4
Datos de la tabla component_types
*/

/* 5
Id, nombre de los facilities
*/
select
    id, name
from facilities;
/* 6
Nombre, elevación e id del facility de las plantas
*/
select
    name, elevation, facilityid
from floors;
/* 7
Nombre, area bruta, volumen de los espacios
*/

/* 8
Nombre, vida útil de los tipos de componentes del facility 1
*/

/* 9
Nombre de los espacios de la Planta 1 del facility 1
*/
select
    name,
    floorid
from spaces
where
    floorid = 1;
/*Previamente se consulta cuál es el floorid
listando los */

/* 10
Nombre, número de modelo del tipo de componente con id = 60
*/

/* 11
Nombre y fecha de instalación de los componentes del espacio 60 ordenados descendentemente por la fecha de instalación
*/
select
    name,
    installatedon,
    spaceid
from components
where
    spaceid = 60
order by installatedon desc;
/* 12
Listar las distintas fechas de instalación de los componentes del facility 1 ordenados descendentemente.
*/
select DISTINCT
    installatedon
from components
where 
    facilityid = 1
order by installatedon DESC;
/* 13
Listar los distintos GUIDs de los componentes del facility 1 ordenados ascendentemente por fecha de garantía.
*/
select DISTINCT
    externalidentifier
from components
where 
    facilityid = 1
order by warrantystarton ASC;
/* 14
Id, código de activo, GUID, número de serie y nombre de los componentes cuyo spaceid está entre 10 y 27 inclusive
ordenados por id de espacio descendentemente.
*/
select
    id,
    assetidentifier,
    serialnumber,
    externalidentifier,
    name
from components
where 
  spaceid >= 10 AND spaceid <=27
order by spaceid DESC;
/* 15
Id, código de activo, GUID, número de serie y nombre de los componentes del facility 1 
ordenados por código de activo descendentemente.
*/
select
    id,
    assetidentifier,
    serialnumber,
    externalidentifier,
    name
from components
where 
  facilityid = 1
order by assetidentifier DESC;
/* 16
Códigos de activo de los componentes del espacio con id 21
ordenados por código de activo descendentemente.
*/
select
    assetidentifier
from components
where 
  spaceid = 21
order by assetidentifier DESC;
/* 17
Las distintas fechas de instalación de los componentes 
de los espacios con id 10, 12, 16, 19 
ordenadas descendentemente.
*/
select DISTINCT
    installatedon
from components
where 
  spaceid = 10 OR spaceid = 12 OR spaceid = 16 OR spaceid = 19
order by installatedon DESC;
/* 18
Nombre, volumen, de los espacios
cuyo volumen es mayor a 90 de floorid = 1
ordenados por volumen descendentemente
*/

/* 19
Nombre, volumen de los espacios
cuyo volumen es mayor a 6 y menor a 9 de la planta con id = 1
*/

/* 20
Nombre, código de activo, número de serie de los componentes
que no tengan espacio del facility 1
ordenados descendentemente por código de activo
*/
select
    name,
    assetidentifier,
    serialnumber,
    spaceid
from components
where facilityid = 1
    and spaceid is null;
/* 21
Nombre, código de activo, número de serie de los componentes
que tengan número de serie del facility 1
*/

/* 22
Nombre de los espacios que empiezan por la letra A donde floorid = 1
*/

/* 23
Lista de espacios que su segunda letra es una 's' donde floorid = 1
*/
select
    name,
    floorid
from spaces
where floorid = 1
and name like '_s%';
/* 24
Lista de tipos de componente del facility 1 
donde el nombre contiene el texto 'con'
y no tienen vida útil indicada o fecha de garantia 
*/

/* 25
Nombres de espacios y volumen
pero como volumen una etiqueta que indique 
'BAJO' si es menor a 10, 'ALTO' si es mayor a 1000
y 'MEDIO' si está entre medias
*/
select
    name,
    volume,
    case
        when volume < 10 then 'BAJO'
        when volume > 1000 then 'ALTO'
        else 'MEDIO'
    end Volumen
from spaces;
/* 26
Nombre, fecha de instalación, fecha de garantia
de los componentes del facility 1
que tienen fecha de garantia
*/

/* 27
Lista de nombres de espacio que su id no es 4, 9, ni 19
del floorid 1
*/

/* 28
Lista de espacios que no son Aula del floorid = 1
*/

/* 29
Lista de los tipos de componentes que tienen duracion de la garantia de las partes
del facility 1
*/

/* 30
Lista de los tipos de componentes que no tiene el coste de repuesto
del facility 1
*/

/* 31
Lista de los tipos de componentes que tienen en el nombre un guión bajo
del facility 1
*/
select
    name
from component_types
where facilityid = 1
and name like '%@_%' escape'@';
--
------------------------------------------------------------------------------------------------
