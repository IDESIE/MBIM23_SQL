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
-- insert into components (id, name, spaceid, typeid)
-- values(
-- 23,
-- 'nombre',
-- 7,
-- 78
-- )


/*
Comprobar que se ven los datos insertados de forma conjunta con una JOIN
y no de forma independiente. Con el fin de comprobar las relaciones.
Mostrar todos los datos indicados en el punto anterior 
y además el nombre del espacio, nombre de la planta, nombre del tipo de componente
*/
-- select
--     components.name,
--     spaces.name, component_types.name,
--     components.createdat
-- from components
--     join spaces on components.spaceid = spaces.id
--     join floors on floors.id = spaces.floorid
-- where
--    name = 'nombre'; 


/* 2
Eliminar el componente creado.
*/
-- delete ... from


/* 3
Colocar como código de barras los 6 últimos caracteres del GUID 
a todo componente de la planta 1 y 2 del facility 1.
*/
-- update components
-- set barcode = substr(externalidentifier, -6)
-- where floorid = 1 or floorid = 2;


/* 4
Modificar la fecha de garantia para que sea igual a la fecha de instalación
para todo componente que sea un grifo o lavabo del facility 1.
*/
-- update components
-- set ...
-- where id is in (select... from...)
-- o, si no:
-- where name like '%lavabo%' or name like '%grifo%'


/* 5
Anonimizar los datos personales: nombre, apellido, email, teléfono de los contactos
*/

