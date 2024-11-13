/*
Pruebas en el usuario de encargado del deposito de la base de datos
LOGIN giovani password qwe333
*/

/*
Permisos de acceso a la base de datos, como el usuario esta asignado unicamente a la base de datos Proyecto_Base_De_Datos
no tiene permiso para acceder a ninguna otra base de datos
*/
use netflix_parcial

use Proyecto_Base_De_Datos

/*
Permisos sobre las tablas, El usuario tiene asignado un rol personalizado que le otorga acceso a las tablas factura,
envios, metodos de pago, de esta manera el usuario puede realizar sus tareas unicamente en las tablas que le corresponden
sin tener la capacidad de alterar el resto, mejorando la seguridad de los datos.
Ademas de que como tiene asignado un rol, si en algun momento se requiere, se le pueden revocar o incluso negar sus permisos
desde el propio rol afectando a todos los usuarios que pertenezcan al mismo
*/

/*
Pruebas erroneas que muestran como no puede realizar ninguna accion en otras tablas
*/
insert into Categorias(descripcion_categoria)
values ('Remeras');

select * from Categorias

update Categorias 
set descripcion_categoria = 'Posters'

delete from Categorias where id_categoria = 1

/*
Pruebas positivas que muestran que cuando manipula las tablas proporcionadas puede realizar sus tareas sin problemas
*/

insert into metodos_de_pagos(metodo)
values ('Transferencia'),('Tarjeta de credito'),('Tarjeta de debito')

select * from metodos_de_pagos

update metodos_de_pagos
set metodo = 'Efectivo'
where id_metodo_pago = 2

delete from metodos_de_pagos where id_metodo_pago = 3
