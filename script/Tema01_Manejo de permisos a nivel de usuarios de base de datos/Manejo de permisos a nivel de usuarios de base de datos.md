En SQL Server el manejo de logins y usuarios es una pieza fundamental en la estructura y la seguridad de servidores y bases de datos respectivamente.

Los logins son entidades de seguridad a nivel de servidores, permiten a un usuario autenticarse en el servidor sirviendo de credenciales con su respectivo usuario y contraseña.
Existen 3 tipos de logins:
SQL Server Logins: Autenticación mediante nombre de usuario y contraseña gestionados por un administrador de SQL Server.
Windows Logins: Autenticación mediante cuentas de usuario de Windows o grupos de Windows.
Certificados y Asymmetric Keys: Menos comunes, usados en casos específicos de seguridad.Para la realización de este trabajo no se incluyeron de este tipo
Los logins de SQL Server se crean mediante el siguiente comando
CREATE LOGIN ‘login_ejemplo’ WITH PASSWORD = ‘contraseña_ejemplo’;

Los usuarios son entidades de seguridad a nivel de bases de datos, están asociados a un login y determinan lo que una persona puede realizar dentro de la base de datos asociada.
Un usuario siempre está asociado a un login pero puede darse el caso de que un login tenga más de un usuario asociado, dándole acceso y permisos a diferentes bases de datos.
Los usuarios se crean mediante el siguiente comando:
CREATE USER ‘Usuario_ejemplo ’ FOR LOGIN ‘Login_creado_previamente’;

Los permisos  definen que puede y que no puede hacer un usuario en su respectiva base de datos, van desde los más simples donde solo se permite leer el contenido de una única tabla hasta la capacidad de poder crear o borrar tablas enteras, debido a esto es un tema importante sobre la seguridad de la base de datos y de su contenido, el saber que permisos otorgar a qué usuario o rol y cuáles directamente denegar para evitar inconsistencias en el futuro.Los permisos se pueden otorgar a cada usuario en específico o asignarles un rol personalizado y brindarle los permisos a este último, de esta manera se vuelve más eficiente la entrega, actualización y quita de permisos a un amplio número de usuarios.
Los permisos se otorgan con el siguiente comando:
GRANT (los permisos que se quieran otorgar) ON (nombre de la tabla) to (usuario o rol)

Los roles son una forma de facilitar el otorgar permisos a una gran cantidad de usuarios,pueden estar asociados a múltiples tablas al mismo tiempo.Existen 2 tipos de roles:
Los creados por un administrador, estos son completamente personalizables, desde su nombre pudiendo hacer referencia a una labor dentro del área en la que se trabaje, como sus límites en todas las tablas asociadas que posea.
Los roles preestablecidos por SQL Server, estos son roles ya creados otorgan permisos generales sobre un servidor entero o sobre una base de datos entera.
Algunos roles preestablecidos son:
Para servidores 
sysadmin: Tiene acceso completo sin restricciones a todas las funcionalidades de SQL Server.
dbcreator: Puede crear, modificar, eliminar y restaurar bases de datos.
securityadmin: Administra inicios de sesión y propiedades de sus bases de datos y puede otorgar, denegar y revocar permisos a nivel de servidor.
Para bases de datos 
db_owner: Tiene todos los permisos de la base de datos, incluida la capacidad de eliminar la base de datos.
db_securityadmin: Administra roles y permisos a nivel de la base de datos.
db_datareader: Puede leer todos los datos en todas las tablas de la base de datos.
