/*Tema: Manejo de transacciones y transacciones anidadas

Objetivos de Aprendizaje:

Entender la consistencia y atomicidad de las transacciones en bases de datos.
Implementar transacciones simples y anidadas para garantizar la integridad de los datos.
Criterios de Evaluación:

Efectividad de las transacciones al manejar errores.
Documentación de pruebas y casos de fallos.
Precisión en la implementación del código de transacciones.
Tareas: 

Escribir el código Transact SQL que permita definir una transacción consistente en: Insertar un registro en alguna tabla, luego otro registro en otra tabla y por último la actualización de uno o más registros en otra tabla. Actualizar los datos solamente si toda la operación es completada con éxito. 
Sobre el código escrito anteriormente provocar intencionalmente un error luego del insert y verificar que los datos queden consistentes (No se debería realizar ningún insert). 
Expresar las conclusiones en base a las pruebas realizadas.*/

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 


/*Código de Transacción Sin Error Intencional 

Categorias:
Se inserta un nuevo registro en esta tabla con la descripción 'Electrodomésticos'.
Se utiliza SCOPE_IDENTITY() para obtener el ID de la categoría recién insertada.

Productos:
Se inserta un nuevo registro en esta tabla utilizando el ID de categoría obtenido en el paso anterior.
Se actualiza el stock del producto recién insertado, asegurando que el stock sea suficiente antes de la actualización.*/


BEGIN TRANSACTION;

BEGIN TRY
    -- Paso 1: Insertar un nuevo registro en la tabla Categorias
    INSERT INTO Categorias (descripcion_categoria) VALUES ('Electrodomésticos');
    DECLARE @id_categoria INT = SCOPE_IDENTITY(); -- Obtener el ID de la categoría recién insertada

    -- Paso 2: Insertar un nuevo registro en la tabla Productos
    INSERT INTO Productos (nombre, precio, stock, stock_minimo, activo, imagen, id_categoria)
    VALUES ('Lavadora', 450.00, 30, 5, 'si', 'lavadora.jpg', @id_categoria);
    DECLARE @id_producto INT = SCOPE_IDENTITY(); -- Obtener el ID del producto recién insertado

    -- Paso 3: Actualizar el stock de un producto existente
    UPDATE Productos
    SET stock = stock - 5
    WHERE id_producto = @id_producto AND stock >= 5;

    -- Confirmar la transacción si todos los pasos son exitosos
    COMMIT TRANSACTION;
    PRINT 'Transacción completada exitosamente.';

END TRY
BEGIN CATCH
    -- En caso de error, deshacer todos los cambios
    ROLLBACK TRANSACTION;
    PRINT 'Transacción fallida. Todos los cambios han sido revertidos.';
    PRINT ERROR_MESSAGE();
END CATCH;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 
/*Código de Transacción Con Error Intencional*/


BEGIN TRANSACTION;

BEGIN TRY
    -- Paso 1: Insertar un nuevo registro en la tabla Categorias
    INSERT INTO Categorias (descripcion_categoria) VALUES ('Electrodomésticos');
    DECLARE @id_categoria INT = SCOPE_IDENTITY(); -- Obtener el ID de la categoría recién insertada

    -- Paso 2: Insertar un nuevo registro en la tabla Productos
    INSERT INTO Productos (nombre, precio, stock, stock_minimo, activo, imagen, id_categoria)
    VALUES ('Lavadora', 450.00, 30, 5, 'si', 'lavadora.jpg', @id_categoria);
    DECLARE @id_producto INT = SCOPE_IDENTITY(); -- Obtener el ID del producto recién insertado

    -- Provocar un error intencional: división por cero
    DECLARE @error INT = 1 / 0;

    -- Paso 3: Actualizar el stock de un producto existente
    UPDATE Productos
    SET stock = stock - 5
    WHERE id_producto = @id_producto AND stock >= 5;

    -- Confirmar la transacción si todos los pasos son exitosos
    COMMIT TRANSACTION;
    PRINT 'Transacción completada exitosamente.';

END TRY
BEGIN CATCH
    -- En caso de error, deshacer todos los cambios
    ROLLBACK TRANSACTION;
    PRINT 'Transacción fallida. Todos los cambios han sido revertidos.';
    PRINT ERROR_MESSAGE();
END CATCH;

/*Error Intencional: Se intenta actualizar un producto con un id_producto que no existe (@id_producto + 1000). 
Manejo de Errores: Si ocurre un error, la transacción se revierte, asegurando que ningún cambio parcial se aplique a la base de datos.*/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 


/* Código de Transacción Con Error Intencional 

Usuarios: Se inserta un nuevo usuario y se obtiene su ID.
Categorias: Se inserta una nueva categoría y se obtiene su ID.
Productos: Se inserta un nuevo producto asociado a la categoría recién creada.
Factura: Se inserta una nueva factura asociada al usuario recién creado. */

INSERT INTO Perfiles (id_perfil, descripcion) VALUES (1, 'Administrador');
INSERT INTO metodos_de_pagos (metodo) VALUES ('Tarjeta de Crédito');

select * from Perfiles
select * from metodos_de_pagos
select * from Categorias

BEGIN TRANSACTION;

BEGIN TRY
    -- Asegúrate de que el perfil existe
    IF NOT EXISTS (SELECT 1 FROM Perfiles WHERE id_perfil = 1)
    BEGIN
        INSERT INTO Perfiles (id_perfil, descripcion) VALUES (1, 'Administrador');
    END

    -- Asegúrate de que el método de pago existe
    IF NOT EXISTS (SELECT 1 FROM metodos_de_pagos WHERE id_metodo_pago = 1)
    BEGIN
        INSERT INTO metodos_de_pagos (metodo) VALUES ('Tarjeta de Crédito');
    END

    DECLARE @id_usuario INT;

    -- Paso 1: Insertar un nuevo usuario solo si no existe
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE email = 'juan.perez@email.com')
    BEGIN
        INSERT INTO Usuarios (nombre, apellido, DNI, email, usuario, pass, domicilio, estado, id_perfil)
        VALUES ('Juan', 'Perez', 12345678, 'juan.perez@email.com', 'juanp', 'password123', 'Calle Falsa 123', 'activo', 1);
        SET @id_usuario = SCOPE_IDENTITY(); -- Obtener el ID del usuario recién insertado
    END
    ELSE
    BEGIN
        -- Obtener el ID del usuario existente
        SELECT @id_usuario = id_usuario FROM Usuarios WHERE email = 'juan.perez@email.com';
    END

    -- Paso 2: Insertar un nuevo registro en la tabla Categorias
    INSERT INTO Categorias (descripcion_categoria) VALUES ('Electrodomésticos');
    DECLARE @id_categoria INT = SCOPE_IDENTITY(); -- Obtener el ID de la categoría recién insertada

    -- Paso 3: Insertar un nuevo registro en la tabla Productos
    INSERT INTO Productos (nombre, precio, stock, stock_minimo, activo, imagen, id_categoria)
    VALUES ('Lavadora', 450.00, 30, 5, 'si', 'lavadora.jpg', @id_categoria);
    DECLARE @id_producto INT = SCOPE_IDENTITY(); -- Obtener el ID del producto recién insertado

    -- Paso 4: Insertar una nueva factura asociada al usuario
    INSERT INTO Factura (total, fecha, id_metodo_pago, id_usuario)
    VALUES (450.00, GETDATE(), 1, @id_usuario);
    DECLARE @id_factura INT = SCOPE_IDENTITY(); -- Obtener el ID de la factura recién insertada

    -- Provocar un error intencional: división por cero
    DECLARE @error INT = 1 / 0;

    -- Confirmar la transacción si todos los pasos son exitosos
    COMMIT TRANSACTION;
    PRINT 'Transacción completada exitosamente.';

END TRY
BEGIN CATCH
    -- En caso de error, deshacer todos los cambios
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    PRINT 'Transacción fallida. Todos los cambios han sido revertidos.';
    PRINT ERROR_MESSAGE();
END CATCH;

/*Comportamiento Esperado
Transacción Fallida: Debido al error de división por cero, la transacción no se completa y se ejecuta el bloque CATCH.
Reversión de Cambios: El ROLLBACK TRANSACTION asegura que todos los cambios realizados durante la transacción se revierten, manteniendo la integridad de la base de datos.
Mensaje de Error: Se imprime un mensaje indicando que la transacción ha fallado y que todos los cambios han sido revertidos, junto con el mensaje de error específico.*/

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 

/*Código de Transacción Sin Error Intencional 

Usuarios: Se inserta un nuevo usuario y se obtiene su ID.
Categorias: Se inserta una nueva categoría y se obtiene su ID.
Productos: Se inserta un nuevo producto asociado a la categoría recién creada.
Factura: Se inserta una nueva factura asociada al usuario recién creado. */

INSERT INTO Perfiles (id_perfil, descripcion) VALUES (1, 'Administrador');
INSERT INTO metodos_de_pagos (metodo) VALUES ('Tarjeta de Crédito');

select * from Perfiles
select * from metodos_de_pagos
select * from Categorias

BEGIN TRANSACTION;

BEGIN TRY
    DECLARE @id_usuario INT;

    -- Paso 1: Insertar un nuevo usuario solo si no existe
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE email = 'juan.perez@email.com')
    BEGIN
        INSERT INTO Usuarios (nombre, apellido, DNI, email, usuario, pass, domicilio, estado, id_perfil)
        VALUES ('Juan', 'Perez', 12345678, 'juan.perez@email.com', 'juanp', 'password123', 'Calle Falsa 123', 'activo', 1);
        SET @id_usuario = SCOPE_IDENTITY(); -- Obtener el ID del usuario recién insertado
    END
    ELSE
    BEGIN
        -- Obtener el ID del usuario existente
        SELECT @id_usuario = id_usuario FROM Usuarios WHERE email = 'juan.perez@email.com';
    END

    -- Paso 2: Insertar un nuevo registro en la tabla Categorias
    INSERT INTO Categorias (descripcion_categoria) VALUES ('Electrodomésticos');
    DECLARE @id_categoria INT = SCOPE_IDENTITY(); -- Obtener el ID de la categoría recién insertada

    -- Paso 3: Insertar un nuevo registro en la tabla Productos
    INSERT INTO Productos (nombre, precio, stock, stock_minimo, activo, imagen, id_categoria)
    VALUES ('Lavadora', 450.00, 30, 5, 'si', 'lavadora.jpg', @id_categoria);
    DECLARE @id_producto INT = SCOPE_IDENTITY(); -- Obtener el ID del producto recién insertado

    -- Paso 4: Insertar una nueva factura asociada al usuario
    INSERT INTO Factura (total, fecha, id_metodo_pago, id_usuario, id_producto_detalle)
    VALUES (450.00, GETDATE(), 1, @id_usuario, 2);
    DECLARE @id_factura INT = SCOPE_IDENTITY(); -- Obtener el ID de la factura recién insertada

    -- Confirmar la transacción si todos los pasos son exitosos
    COMMIT TRANSACTION;
    PRINT 'Transacción completada exitosamente.';

END TRY
BEGIN CATCH
    -- En caso de error, deshacer todos los cambios
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    PRINT 'Transacción fallida. Todos los cambios han sido revertidos.';
    PRINT ERROR_MESSAGE();
END CATCH;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 



/*Conclusiones
Atomicidad de las Transacciones:
Las transacciones en SQL Server aseguran que un conjunto de operaciones se ejecute de manera atómica. Esto significa que todas las operaciones dentro de una transacción se completan con éxito o ninguna se aplica. 
Esto es crucial para mantener la integridad de los datos en la base de datos.

Manejo de Errores:
El uso de bloques TRY - CATCH permite manejar errores de manera efectiva dentro de las transacciones. Si ocurre un error en cualquier parte de la transacción, el bloque CATCH se ejecuta, 
permitiendo revertir todos los cambios realizados hasta ese punto con ROLLBACK TRANSACTION. Esto asegura que la base de datos no quede en un estado inconsistente.

Consistencia de los Datos:
Las pruebas demostraron que las transacciones mantienen la consistencia de los datos. En los casos donde se provocaron errores intencionales, como la división por cero o la violación de restricciones de clave externa, 
la transacción se revirtió correctamente, asegurando que ningún cambio parcial se aplicara a la base de datos.

Verificación de Condiciones Previas:
Es importante verificar las condiciones previas antes de realizar operaciones dentro de una transacción. Por ejemplo, asegurarse de que los registros necesarios existen antes de 
intentar insertar o actualizar datos relacionados. Esto previene errores de clave externa y asegura que las operaciones se realicen de manera exitosa.

Pruebas de Escenarios de Error:
Probar escenarios de error es fundamental para garantizar que las transacciones se manejen correctamente. Introducir errores intencionales durante las pruebas ayuda a verificar que el sistema 
responde adecuadamente, manteniendo la integridad de los datos.

Eficiencia y Rendimiento:
Aunque las transacciones aseguran la integridad de los datos, también pueden afectar el rendimiento si no se manejan adecuadamente. Es importante diseñar transacciones que sean lo más cortas posible 
para minimizar el tiempo de bloqueo de los recursos de la base de datos.

Estas conclusiones resaltan la importancia de las transacciones en el manejo seguro y eficiente de las operaciones de base de datos, asegurando que los datos permanezcan consistentes y que los errores se manejen de manera efectiva.*/