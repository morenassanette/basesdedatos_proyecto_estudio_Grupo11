/*
Pruebas en el usuario de solo contactos de la base de datos
LOGIN vicente password qwe111
*/

/*
Permisos de acceso a la base de datos, como el usuario esta asignado unicamente a la base de datos Proyecto_Base_De_Datos
no tiene permiso para acceder a ninguna otra base de datos
*/
use netflix_parcial

use Proyecto_Base_De_Datos

/*
Permisos sobre las tablas, como el usuario tiene permisos unicamente sobre la tabla contactos, solo puede acceder a la misma
de esta manera se limita el alcance que puede tener un usuario si sus funciones se limitan a una unica tabla
*/

select * from factura

select * from Contacto

INSERT INTO Contacto (nombre, apellido, email, consulta) VALUES (' Mauricio', ' Covarrubias', 'Alexandro72@yahoo.com', ' ¿Puedo pagar en efectivo al recibir el pedido?');

update Contacto
set respuesta = 'No contamos con ese metodo de pago en este momento',
respondido = 'si'
where consulta like '¿Puedo pagar en efectivo al recibir el pedido?'

delete from Contacto
where id_contacto = 1
