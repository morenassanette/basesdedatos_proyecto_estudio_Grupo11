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
GRANT (los permisos que se quieran otorgar) 
