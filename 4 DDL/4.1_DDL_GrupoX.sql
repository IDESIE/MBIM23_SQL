------------------------------------------------------------------------------------------------
-- DDL
------------------------------------------------------------------------------------------------
/* 
Se desea tener una base de datos con la información de instalaciones/edificios (falicities).
-Información acerca de las plantas, nombre, categoria, descripción, GUID (Global Unique identifier), altura.
-Sobre los espacios, nombre, categoria, descripción, altura usable, area, GUID
-componentes, nombre, descripción, GUID, numero de serie, fecha de instalación
-tipo de componentes, nombre, descripción, modelo, GUID, material, color, años de garantia

1-Generar las siguientes tablas
FACILITIES
id
guid
name
description
category
address

FLOORS
id
guid
name
category
description
height
facilityId

SPACES
id
guid
name
category
description
usableHeight
area
floorId

COMPONENTS
id
guid
name
description
serialNumber
installatedOn
spaceId
typeId

TYPES
id
guid
name
description
modelNumber
color
warrantyYears


En las definiciones establacer las siguientes restricciones
-Los guid deben ser únicos.
-No es posible dar de alta un componente sin un tipo.
-No es posible dar de alta un espacio sin una planta.
-No es posiblde dar de alta una planta sin un facility.
-Dos componentes no pueden llamarse igual, lo mismo pasa con el resto de entidades.
-La fecha de instalación de un componente por defecto es la actual.
-Los nombres no pueden estar vacíos en todas las entidades.
-Los años de garantia no pueden ser cero ni negativos.
-Se debe mantener la integridad referencial.

NOTA: Algunos ejercicios provocan errores que deben probar (para ver el error) y corregir.
*/
--------------------------------------------------------
--  DROP TABLES
--------------------------------------------------------
DROP TABLE CB_COMPONENTS CASCADE CONSTRAINTS;
DROP TABLE CB_COMPONENT_TYPES CASCADE CONSTRAINTS;
DROP TABLE CB_FLOORS CASCADE CONSTRAINTS;
DROP TABLE CB_SPACES CASCADE CONSTRAINTS;
DROP TABLE CB_FACILITIES CASCADE CONSTRAINTS;
--------------------------------------------------------
--  DDL for Table CB_COMPONENTS
--------------------------------------------------------

  CREATE TABLE CB_COMPONENTS 
   (COMPONENTID         NUMBER(10,0), 
    NAME                VARCHAR2(255), 
    DESCRIPTION         VARCHAR2(512), 
    EXTERNALIDENTIFIER  VARCHAR2(512), 
    SERIALNUMBER        VARCHAR2(255), 
    INSTALLATEDON       DATE, 
    WARRANTYSTARTON     DATE, 
    ASSETIDENTIFIER     VARCHAR2(255), 
    SPACEID             NUMBER(10,0), 
    TYPEID              NUMBER(10,0), 
    REPLACEDON          DATE, 
    FACILITYID          NUMBER(10,0),
    CREATEDBY           VARCHAR2(255),
    UPDATEDBY           VARCHAR2(255),
    CREATEDON           DATE DEFAULT SYSDATE, 
    UPDATEDON           DATE
   ) ;
--------------------------------------------------------
--  DDL for Table CB_COMPONENT_TYPES
--------------------------------------------------------

  CREATE TABLE CB_COMPONENT_TYPES 
   (TYPEID              NUMBER(10,0), 
    NAME                VARCHAR2(255), 
    DESCRIPTION         VARCHAR2(512), 
    MODELNUMBER         VARCHAR2(255), 
    WARRANTYYEARS       NUMBER(10,0), 
    WARRANTYGUARANTOR   VARCHAR2(255),
    REPLACEMENTCOST     NUMBER(38,2), 
    EXPECTEDLIFE        NUMBER(10,0),  
    FACILITYID          NUMBER(10,0), 
    CREATEDBY           VARCHAR2(255),
    UPDATEDBY           VARCHAR2(255),
    CREATEDON           DATE DEFAULT SYSDATE, 
    UPDATEDON           DATE
   ) ;
--------------------------------------------------------
--  DDL for Table CB_FACILITIES
--------------------------------------------------------

  CREATE TABLE CB_FACILITIES 
   (FACILITYID          NUMBER(10,0), 
    NAME                VARCHAR2(255), 
    DESCRIPTION         VARCHAR2(255), 
    CREATEDBY           VARCHAR2(255),
    UPDATEDBY           VARCHAR2(255),
    CREATEDON           DATE DEFAULT SYSDATE, 
    UPDATEDON           DATE
   );
--------------------------------------------------------
--  DDL for Table CB_FLOORS
--------------------------------------------------------

  CREATE TABLE CB_FLOORS 
   (FLOORID             NUMBER(10,0), 
    NAME                VARCHAR2(255),
    DESCRIPTION         VARCHAR2(512), 
    ELEVATION           NUMBER(38,2), 
    FACILITYID          NUMBER(10,0),
    CREATEDBY           VARCHAR2(255),
    UPDATEDBY           VARCHAR2(255),
    CREATEDON           DATE DEFAULT SYSDATE, 
    UPDATEDON           DATE
   ) ;
--------------------------------------------------------
--  DDL for Table CB_SPACES
--------------------------------------------------------

  CREATE TABLE CB_SPACES 
   (SPACEID             NUMBER(10,0), 
    NAME                VARCHAR2(255), 
    DESCRIPTION         VARCHAR2(512), 
    USABLEHEIGHT        NUMBER(38,2), 
    NETAREA             NUMBER(38,2), 
    VOLUME              NUMBER(38,2), 
    FLOORID             NUMBER(10,0),
    CREATEDBY           VARCHAR2(255),
    UPDATEDBY           VARCHAR2(255),
    CREATEDON           DATE DEFAULT SYSDATE, 
    UPDATEDON           DATE
   ) ;

--------------------------------------------------------
--  Constraints for Table CB_COMPONENTS
--------------------------------------------------------

  ALTER TABLE CB_COMPONENTS ADD CONSTRAINT UK_CBCOMPONENTS_GUID UNIQUE (EXTERNALIDENTIFIER);
  ALTER TABLE CB_COMPONENTS ADD CONSTRAINT PK_CBCOMPONENTS_ID PRIMARY KEY (COMPONENTID);
  ALTER TABLE CB_COMPONENTS MODIFY (TYPEID NOT NULL ENABLE);
  ALTER TABLE CB_COMPONENTS MODIFY (CREATEDBY NOT NULL ENABLE);
  ALTER TABLE CB_COMPONENTS MODIFY (CREATEDON NOT NULL ENABLE);
  ALTER TABLE CB_COMPONENTS MODIFY (EXTERNALIDENTIFIER NOT NULL ENABLE);
  ALTER TABLE CB_COMPONENTS MODIFY (NAME NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CB_COMPONENT_TYPES
--------------------------------------------------------

  ALTER TABLE CB_COMPONENT_TYPES MODIFY (CREATEDBY NOT NULL ENABLE);
  ALTER TABLE CB_COMPONENT_TYPES MODIFY (CREATEDON NOT NULL ENABLE);
  ALTER TABLE CB_COMPONENT_TYPES ADD CONSTRAINT PK_CBTYPES_ID PRIMARY KEY (TYPEID);
  ALTER TABLE CB_COMPONENT_TYPES MODIFY (NAME NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CB_FACILITIES
--------------------------------------------------------

  ALTER TABLE CB_FACILITIES ADD CONSTRAINT PK_CBFACILITIES_ID PRIMARY KEY (FACILITYID);
  ALTER TABLE CB_FACILITIES MODIFY (CREATEDBY NOT NULL ENABLE);
  ALTER TABLE CB_FACILITIES MODIFY (CREATEDON NOT NULL ENABLE);
  ALTER TABLE CB_FACILITIES MODIFY (NAME NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CB_FLOORS
--------------------------------------------------------

  ALTER TABLE CB_FLOORS ADD CONSTRAINT PK_CBFLOORS_ID PRIMARY KEY (FLOORID);
  ALTER TABLE CB_FLOORS MODIFY (FACILITYID NOT NULL ENABLE);
  ALTER TABLE CB_FLOORS MODIFY (CREATEDBY NOT NULL ENABLE);
  ALTER TABLE CB_FLOORS MODIFY (CREATEDON NOT NULL ENABLE);
  ALTER TABLE CB_FLOORS MODIFY (NAME NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CB_SPACES
--------------------------------------------------------

  ALTER TABLE CB_SPACES MODIFY (FLOORID NOT NULL ENABLE);
  ALTER TABLE CB_SPACES MODIFY (CREATEDBY NOT NULL ENABLE);
  ALTER TABLE CB_SPACES MODIFY (CREATEDON NOT NULL ENABLE);
  ALTER TABLE CB_SPACES MODIFY (NAME NOT NULL ENABLE);
  ALTER TABLE CB_SPACES ADD CONSTRAINT PK_CBSPACES_ID PRIMARY KEY (SPACEID);

--------------------------------------------------------
--  Ref Constraints for Table CB_COMPONENTS
--------------------------------------------------------

  ALTER TABLE CB_COMPONENTS ADD CONSTRAINT FK_CBCOMPONENTS_FACILITYID FOREIGN KEY (FACILITYID)
	  REFERENCES CB_FACILITIES (FACILITYID) ENABLE;
  ALTER TABLE CB_COMPONENTS ADD CONSTRAINT FK_CBCOMPONENTS_SPACEID FOREIGN KEY (SPACEID)
	  REFERENCES CB_SPACES (SPACEID) ENABLE;
  ALTER TABLE CB_COMPONENTS ADD CONSTRAINT FK_CBCOMPONENTS_TYPEID FOREIGN KEY (TYPEID)
	  REFERENCES CB_COMPONENT_TYPES (TYPEID) ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table CB_COMPONENT_TYPES
--------------------------------------------------------

  ALTER TABLE CB_COMPONENT_TYPES ADD CONSTRAINT FK_CBTYPES_FACILITYID FOREIGN KEY (FACILITYID)
	  REFERENCES CB_FACILITIES (FACILITYID) ENABLE;

--------------------------------------------------------
--  Ref Constraints for Table CB_FLOORS
--------------------------------------------------------

  ALTER TABLE CB_FLOORS ADD CONSTRAINT FK_CBFLOORS_FACILITYID FOREIGN KEY (FACILITYID)
	  REFERENCES CB_FACILITIES (FACILITYID) ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table CB_SPACES
--------------------------------------------------------

  ALTER TABLE CB_SPACES ADD CONSTRAINT FK_CBSPACES_FOOLID FOREIGN KEY (FLOORID)
	  REFERENCES CB_FLOORS (FLOORID) ENABLE;
