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

update Contacto
set respuesta = 'No contamos con un local fisico en este momento, todas nuestas ventas son unicamente por la tienda online',
respondido = 'si'
where id_contacto = 2

delete from Contacto
where id_contacto = 500