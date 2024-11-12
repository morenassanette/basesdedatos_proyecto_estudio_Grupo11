
/*
Se crean 4 usuarios de base de datos, cada uno con su respectivo LOGIN y contraseña
*/


CREATE LOGIN vicente WITH PASSWORD = 'qwe111';

CREATE LOGIN morena WITH PASSWORD = 'qwe222';

CREATE LOGIN giovani WITH PASSWORD = 'qwe333';

CREATE LOGIN emilio WITH PASSWORD = 'qwe444';

CREATE LOGIN pruebas WITH PASSWORD = '111';




/*
Con los LOGIN creados, el siguiente paso es conectarse a la base de datos que se va a utilizar
y se crean los usuarios en la misma
*/

USE Proyecto_Base_De_Datos;

CREATE USER solo_contactos from LOGIN vicente;

CREATE USER	administrador from LOGIN morena;

CREATE USER empleado_deposito from LOGIN emilio;

CREATE USER empleado_ventas from LOGIN giovani;

CREATE USER pruebas from LOGIN pruebas;


/*
Se crean roles que engloban tareas mas especificas para luego asignarles permisos a estos mismos,
de esta forma es mas facil y seguro asignarle permisos a multiples usuarios
*/

CREATE ROLE encargado_deposito;

CREATE ROLE encargado_ventas;

/*
Se asignan los permisos a un usuario concreto
y se le asignan los permisos a los roles personalizados creados previamente
*/

GRANT SELECT,INSERT,DELETE,UPDATE ON Contacto to solo_contactos;

GRANT SELECT ON Contacto to pruebas;

GRANT SELECT,INSERT,UPDATE ON Productos to encargado_deposito;
GRANT SELECT,INSERT,UPDATE ON producto_detalle to encargado_deposito;
GRANT SELECT,INSERT,UPDATE ON Categorias to encargado_deposito;

GRANT SELECT,INSERT,UPDATE ON Factura to encargado_ventas;
GRANT SELECT,INSERT,UPDATE ON envios to encargado_ventas;
GRANT SELECT,INSERT,UPDATE ON metodos_de_pagos to encargado_ventas;


/*
Se asignan roles a los usuarios pertinentes, siendo el db_owner un rol ya definido y que concede permisos de admin
unicamente a la base de datos a la que pertenece el usuario
*/

EXEC sp_addrolemember 'encargado_deposito', 'empleado_deposito'

EXEC sp_addrolemember 'encargado_ventas', 'empleado_ventas'

EXEC sp_addrolemember 'db_owner' , 'administrador'


/*
Todas las pruebas realizadas se encuentran en sus respectivas Query
*/

/*
Conclusiones:
El manejo de permisos en una base de datos es una tarea vital para mantener no solo la integridad de los datos
si no tambien la integridad de las propias estructuras de la misma, pudiendo conceder desde permisos de solo lectura
hasta permisos de creacion de tablas o de bases enteras.
la existencia de los roles facilita que dichos permisos puedan ser otorgados de manera eficiente en organizaciones
con un gran volumen de empleados con las mismas tareas.Ademas permite que en caso de que se modifiquen dichos permisos,
el cambio sea inmediato para todos los usuarios que posean ese rol asignado, resultando en un sistema mas seguro.
*/