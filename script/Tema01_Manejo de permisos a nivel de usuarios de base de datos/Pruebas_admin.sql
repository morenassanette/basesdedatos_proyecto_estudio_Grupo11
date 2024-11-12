/*
Pruebas en el usuario administrador de la base de datos
LOGIN morena password qwe222
*/

/*
Permisos de acceso a la base de datos, como el usuario esta asignado unicamente a la base de datos Proyecto_Base_De_Datos
no tiene permiso para acceder a ninguna otra base de datos
*/
use netflix_parcial

use Proyecto_Base_De_Datos

/*
Permisos sobre las tablas, como el usuario tiene asignado el rol de dbowner este mismo tiene la capacidad de 
crear,modificar y eliminar todas las tablas que desee, es un rol muy importante que solo debe tener una persona 
capacitada y de suma confianza
*/

Create table tabla_nueva(
idtabla int identity not null,
descripcion varchar(50),
PRIMARY KEY (idtabla)
);

alter table tabla_nueva
alter column descripcion varchar(100)

alter table tabla_nueva
add nombre varchar(50)

insert into tabla_nueva(descripcion,nombre)
values('descripcion nueva','nueva')

select * from tabla_nueva

drop table tabla_nueva
