------------------------------------------------------------------------------------------------
-- SELECT con subcolsultas y JOINS
------------------------------------------------------------------------------------------------
/*1
Listar de la tabla facilities el id y nombre, 
además de la tabla floors el id, nombre y facilityid
*/
select
    facilities.id FacilitiesId,
    facilities.name FacilitiesName,
    floors.id FloorsId,
    floors.name FloorsName,
    floors.facilityid FloorsFacilityId
from
    facilities
    join floors on facilities.id = floors.facilityid;
/*2
Lista de id de espacios que no están en la tabla de componentes (spaceid)
pero sí están en la tabla de espacios.
*/ 
select
    spaces.id
from
    spaces
JOIN COMPONENTS ON SPACE.ID = components.spaceid
WHERE SPACEID NOT IN (SELECT COMPONENTS.SPACEID FROM COMPONENTS);

/*3
Lista de id de tipos de componentes que no están en la tabla de componentes (typeid)
pero sí están en la tabla de component_types
*/
select
    id
from component_types
JOIN COMPONENTS ON component_types.id = COMPONENTS.component_types.id
WHERE TYPEID NOT IN (SELECT typeid FROM components);

/*4
Mostrar de la tabla floors los campos: name, id;
y de la tabla spaces los campos: floorid, id, name
de los espacios 109, 100, 111
*/
select
    FLOORS.NAME,
    FLOORS.ID,
    SPACES.FLOORID,
    SPACES.ID,
    SPACES.NAME
FROM floors JOIN spaces ON FLOORS.ID = spaces.floorid
WHERE SPACES.ID = 109 OR SPACES.ID = 100 OR SPACES.ID = 111;

/*5
Mostrar de component_types los campos: material, id;
y de la tabla components los campos: typeid, id, assetidentifier
de los componentes con id 10000, 20000, 300000
*/
select
    MATERIAL,
    ID,
    COMPONENTS.TYPEID,
    COMPONENTS.ID,
    COMPONENTS.ASSETIDENTIFIER
FROM COMPONENT_TYPE
JOIN components ON component_types.ID = components.id
WHERE COMPONENTS.ID = 10000 OR COMPONENTS.ID = 20000 OR COMPONENTS.ID = 30000;

/*6
¿Cuál es el nombre de los espacios que tienen cinco componentes?
*/
select
    spaces.name,
    count (components.name)
from spaces join components on spaces.id = components.spaceid
group by spaces.name
having count (components.name) = 5;

/*7
¿Cuál es el id y assetidentifier de los componentes
que están en el espacio llamado CAJERO?
*/
select
    spaces.name,
    components.id, 
    components.assetidentifier
from spaces join components on spaces.id = components.spaceid
where spaces.name = 'CAJERO'

/*8
¿Cuántos componentes
hay en el espacio llamado CAJERO?
*/
select
    count(*)
from
    components join spaces on components.spaceid = spaces.id
where
    spaces.name = 'CAJERO';

/*9
Mostrar de la tabla spaces: name, id;
y de la tabla components: spaceid, id, assetidentifier
de los componentes con id 10000, 20000, 30000
aunque no tengan datos de espacio.
*/
select
    spaces.id,
    spaces.name,
    components.name,
    components.assetidentifier,
    components.id 
from spaces right join components on spaces.id = components.spaceid
where components.id = 10000 or components.id = 20000 or components.id = 30000;

/*
10
Listar el nombre de los espacios y su área del facility 1
*/
select
    spaces.name,
    spaces.grossarea,
    facilities.id
from
    components
    join spaces on components.spaceid = spaces.id
    join facilities on components.facilityid = facilities.id
where
    facilities.id = 1;

/*11
¿Cuál es el número de componentes por facility?
Mostrar nombre del facility y el número de componentes.
*/
SELECT
    facilities.name,
    count(components.name)
FROM 
    facilities
    join components on facilities.id = components.facilityid
group by facilities.name;

/*12
¿Cuál es la suma de áreas de los espacios por cada facility?
Mostrar nombre del facility y la suma de las áreas 
*/
select
    facilities.name,
    sum(spaces.grossarea)
from
    components
    join spaces on components.spaceid = spaces.id
    join facilities on components.facilityid = facilities.id
group by facilities.name;


/*13
¿Cuántas sillas hay de cada tipo?
Mostrar el nombre del facility, el nombre del tipo
y el número de componentes de cada tipo
ordernado por facility.
*/
select
    facilities.name Edificio,
    component_types.name Nombre,
    count(component_types.name) Número
from
    components
    join facilities on components.facilityid = facilities.id
    join component_types on components.typeid = component_types.id
where
    lower(component_types.name) like '%silla%'
group by facilities.name,
    component_types.name
order by Edificio, Nombre;


--Ejemplo
--Alegra	Silla-Apilable_Silla-Apilable	319
--Alegra	Silla-Brazo escritorio_Silla-Brazo escritorio	24
--Alegra	Silla (3)_Silla (3)	24
--Alegra	Silla-Corbu_Silla-Corbu	20
--Alegra	Silla-Oficina (brazos)_Silla-Oficina (brazos)	17
--COSTCO	Silla-Apilable_Silla-Apilable	169
--COSTCO	Silla_Silla	40
--COSTCO	Silla-Corbu_Silla-Corbu	14
--COSTCO	Silla-Oficina (brazos)_Silla-Oficina (brazos)	188

/*
14
Listar nombre, código de asset, número de serie, el año de instalación, nombre del espacio,
de todos los componentes
del facility 1
que estén en un aula y no sean tuberias, muros, techos, suelos.
*/
select
    components.name Nombre,
    spaces.name Espacio,
    components.assetidentifier,
    components.serialnumber,
    to_char(components.installatedon, 'yyyy') Año 
from components   
    join
        spaces on spaces.id = components.spaceid
where FACILITYID = 1
    and lower(spaces.name) like '%aula%'
        and lower(components.name) not like '%suelo%'
        and lower(components.name) not like '%muro%'
        and lower(components.name) not like '%techo%'
        and components.name not like '%tuberÃ-a%';

/*
15
Nombre, área bruta y volumen de los espacios con mayor área que la media de áreas del facility 1.
*/
select
    floors.name, netarea, volume
from spaces
join floors on spaces.floorid = floors.id
where
    facilityid = 1
    and netarea > (
    SELECT
        avg(netarea)
    FROM
        spaces
        join floors on spaces.floorid = floors.id
    where
        facilityid = 1);

/*
16
Nombre y fecha de instalación (yyyy-mm-dd) de los componentes del espacio con mayor área del facility 1
*/

select
    components.name Componente,
    spaces.name Espacio,
    to_char(components.installatedon, 'yyyy-mm-dd') Fecha,
    spaces.netarea Area
from components   
    join
        spaces on spaces.id = components.spaceid
where FACILITYID = 1
    and spaces.netarea =(select
                            max(spaces.netarea)
                        from spaces
                            join
                                floors on floors.id = spaces.floorid
                                    where floors.facilityid = 1);
/*
17
Nombre y código de activo  de los componentes cuyo tipo de componente contenga la palabra 'mesa'
del facility 1
*/
select
    components.name Nombre_componente,
    components.assetidentifier,
    components.facilityid
from components
    join component_types
        on component_types.id = components.typeid   
    where components.facilityid = 1
        and lower(component_types.name) like '%mesa%';

/*
18
Nombre del componente, espacio y planta de los componentes
de los espacios que sean Aula del facility 1
*/
select
    components.name,
    spaces.name Space,
    spaces.floorid Floor,
    components.facilityid Facility  
from components
    join spaces
        on components.spaceid = spaces.id
    where components.facilityid = 1 
        and lower(spaces.name) like '%aula%';

/*
19
Número de componentes y número de espacios por planta (nombre) del facility 1. 
Todas las plantas.
*/
select
    f.id AS id_planta,
    COUNT(DISTINCT s.id) AS total_espacios,
    COUNT(c.id) AS total_componentes
from
    floors f
left join
    spaces s ON f.id = s.floorid
left join
    components c ON s.id = c.spaceid
where
    f.facilityid = 1
group by
    f.id;

/*
20
Número de componentes por tipo de componente en cada espacio
de los componentes que sean mesas del facility 1
ordenados de forma ascendente por el espacio y descentente por el número de componentes.
Ejmplo:
Componentes    Tipo   Espacio
--------------------------------
12  Mesa-cristal-redonda    Aula 2
23  Mesa-4x-reclinable      Aula 3
1   Mesa-profesor           Aula 3
21  Mesa-cristal-redonda    Aula 12
*/
SELECT
    COUNT(c.id) AS numero_componentes,
    ct.name AS tipo_componente,
    s.name AS nombre_espacio
FROM
    components c
JOIN
    component_types ct ON c.typeid = ct.id
JOIN
    spaces s ON c.spaceid = s.id
WHERE
    c.facilityid = 1
    AND lower(ct.name) like '%mesa%'
GROUP BY
    s.id, s.name, ct.name
ORDER BY
    s.id ASC, numero_componentes DESC;

/*
21
Mostrar el nombre de las Aulas y una etiqueda «Sillas» que indique
'BAJO' si el número de sillas es menor a 6
'ALTO' si el número de sillas es mayor a 15
'MEDIO' si está entre 6 y 15 inclusive
del facility 1
ordenado ascendentemente por el espacio
Ejemplo:
Espacio Sillas
--------------
Aula 1  BAJO
Aula 2  BAJO
Aula 3  MEDIO
*/
SELECT
    s.name AS nombre_espacio,
    CASE
        WHEN COUNT(CASE WHEN lower(c.name) like '%silla%' THEN 1 ELSE NULL END) < 5 THEN 'BAJO'
        WHEN COUNT(CASE WHEN lower(c.name) like '%silla%' THEN 1 ELSE NULL END) BETWEEN 6 AND 15 THEN 'MEDIO'
        ELSE 'ALTO'
    END AS clasificacion_sillas
FROM
    spaces s
LEFT JOIN
    components c ON s.id = c.spaceid
WHERE
    c.facilityid = 1
    AND lower(s.name) like '%aula%'
GROUP BY
    s.name
ORDER BY
    s.name ASC;


/*
22
Tomando en cuenta los cuatro primeros caracteres del nombre de los espacios
del facility 1
listar los que se repiten e indicar el número.
En orden descendente por el número de ocurrencias.
Ejemplo:
Espacio Ocurrencias
Aula    18
Aseo    4
Hall    2
*/
select count(*)
from components
    join component_types on component_types.id = components.typeid
where components.facilityid = 1
    and (lower(component_types.name) like '%lavabo%'
        or lower(component_types.name) like '%grifo%') 
    and (installatedon between to_date('2010-05-01', 'yyyy-mm-dd')
     and to_date('2010-08-31', 'yyyy-mm-dd'));


/*
23
Nombre y área del espacio que mayor área bruta tiene del facility 1.
*/
select 
    SPACES.NAME,
    spaces.grossarea
FROM SPACES JOIN floors ON spaces.floorid = floors.ID
WHERE floors.facilityid = 1;

/*
24
Número de componentes instalados entre el 1 de mayo de 2010 y 31 de agosto de 2010
y que sean grifos, lavabos del facility 1
*/
SELECT COUNT(*) AS Componentes
FROM components c
JOIN spaces s ON c.spaceid = s.id
JOIN floors f ON s.floorid = f.id
WHERE (c.name = 'grifo' OR c.name = 'lavabo')
AND f.facilityid = 1
AND c.installatedon BETWEEN '01-05-2010' AND '31-08-2010';

/*
25
Un listado en el que se indique en líneas separadas
una etiqueta que describa el valor, y el valor:
el número de componentes en Aula 03 del facility 1, 
el número de sillas en Aula 03 del facility 1
el número de mesas o escritorios en Aula 03 del facility 1
Ejemplo:
Componentes 70
Sillas 16
Mesas 3
*/


/*
26
Nombre del espacio, y número de grifos del espacio con más grifos del facility 1.
*/


/*
27
Cuál es el mes en el que más componentes se instalaron del facility 1.
*/
select
    count(components.name),
    to_char(components.installatedon, 'Month')
from components
where components.facilityid = 1
group by to_char(components.installatedon, 'Month')
having count(components.name) = (
        select max(count(components.name))
        from components
        where components.facilityid = 1
        group by to_char(components.installatedon, 'Month')
    );

/* 28
Nombre del día en el que más componentes se instalaron del facility 1.
Ejemplo: Jueves
*/

/*29
Listar los nombres de componentes que están fuera de garantía del facility 1.
*/

/*
30
Listar el nombre de los tres espacios con mayor área del facility 1
*/
select
    rownum, spaceName, area
from ( select rownum Fila, spaces.name spaceName, netarea Area
        from spaces
            join floors on spaces.floorid = floors.id
        where facilityid = 1
        order by 3 desc)
where rownum < 4;
------------------------------------------------------------------------------------------------
