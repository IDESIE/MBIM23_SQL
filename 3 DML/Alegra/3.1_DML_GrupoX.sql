------------------------------------------------------------------------------------------------
-- DML
------------------------------------------------------------------------------------------------
/* 1
Insertar un componente en el facility 1 
con nombre «Grifo | Grifo | 030303» 
descripcion «test insert»
número de serie «666333-eeefff»
fecha de instalación «2021-12-12»
inicio de garantia «2021-11-11»
código de activo «666000»
id del creador «3»
id del espacio «7»
id de tipo «78»
guid «666000»
*/
insert into components (
    id,
    name,
    description,
    serialnumber,
    installatedon,
    warrantystarton,
    assetidentifier,
    createdat,
    creatorid,
    spaceid,
    typeid,
    externalidentifier)
values ((select max(id) + 1 from components),
    'Grifo | Grifo | 030303',
    'test insert',
    '666333-eeefff',
    to_date('2021-12-12', 'yyyy-mm-dd'),
    to_date('2021-11-11', 'yyyy-mm-dd'),
    '666000',
    sysdate,
    3,
    7,
    78,
    '666000');
/*
Comprobar que se ven los datos insertados de forma conjunta con una JOIN
y no de forma independiente. Con el fin de comprobar las relaciones.
Mostrar todos los datos indicados en el punto anterior 
y además el nombre del espacio, nombre de la planta, nombre del tipo de componente
*/
select
    components.id,
    components.name,
    components.description,
    components.serialnumber,
    components.installatedon,
    components.warrantystarton,
    components.assetidentifier,
    components.createdat,
    components.creatorid,
    components.spaceid,
    components.typeid,
    components.externalidentifier,
    spaces.name,
    floors.name,
    component_types.name
from components
    join spaces on components.spaceid = spaces.id
    join floors on floors.id = spaces.floorid
    join component_types on components.typeid = component_types.id
where
   externalidentifier = '666000';
/* 2
Eliminar el componente creado.
*/
delete from components
where externalidentifier = '666000';
/* 3
Colocar como código de barras los 6 últimos caracteres del GUID 
a todo componente de la planta 1 y 2 del facility 1.
*/
UPDATE components
SET barcode = (SELECT substr(c.externalidentifier, -6)
    FROM components c
    JOIN spaces s ON c.spaceid = s.id
    WHERE (s.floorid = 1 OR s.floorid = 2) AND c.id = components.id)
WHERE EXISTS (SELECT 1
    FROM components c
    JOIN spaces s ON c.spaceid = s.id
    WHERE (s.floorid = 1 OR s.floorid = 2) AND c.id = components.id);
/* 4
Modificar la fecha de garantia para que sea igual a la fecha de instalación
para todo componente que sea un grifo o lavabo del facility 1.
*/
update components
set warrantystarton = installatedon
where id in (select id
    from components
    where facilityid = 1 and
    (lower(name) like '%lavabo%' or lower(name) like '%grifo%'));
/* 5
Anonimizar los datos personales: nombre, apellido, email, teléfono de los contactos
*/
