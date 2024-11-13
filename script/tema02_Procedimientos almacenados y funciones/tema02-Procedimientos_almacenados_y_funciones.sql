-- PROCEDIMIENTOS ALMACENADOS Y FUNCIONES
use Proyecto_Base_De_Datos
go

-- Alta de un producto -- 

-- Procedimiento almacenado para dar de alta un producto
CREATE PROCEDURE Alta_Producto ( --Se declaran todos los parámetros que recibirá el procedimiento, que son los atributos de un producto
@nombre varchar (100),
@precio float,
@stock int,
@stock_minimo int,
@activo varchar (2),
@imagen varchar (250),
@id_categoria int
) as begin 
begin try -- se intenta comenzar la transacción
declare @id_producto int = 0
-- se inicia la transacción, donde se declara el INSERT para un producto y la propiedad IDENTITY de id_producto
begin transaction alta

insert into Productos (nombre, precio, stock, stock_minimo, activo, imagen, id_categoria) VALUES (@nombre, @precio, @stock, @stock_minimo, @activo, @imagen, @id_categoria)
SET @id_producto = SCOPE_IDENTITY()

commit transaction alta
end try
begin catch -- en el caso de que la transacción falle, se activa el bloque catch, que ejecuta el rollback que devuelve la base al estado anterior
rollback transaction alta
 DECLARE @ErrorMessage NVARCHAR(4000);
    SET @ErrorMessage = ERROR_MESSAGE();
    RAISERROR(@ErrorMessage, 16, 1);
end catch
end

-- prueba del procedimiento Alta_Producto
EXECUTE Alta_Producto 'otro producto', '434444', '4', '2', 'SI', 'https://loremflickr.com/640/480',1;

-- prueba de un INSERT explicíto
INSERT INTO Productos (nombre, precio, stock, stock_minimo, activo, imagen, id_categoria)
VALUES ('producto', '4544', '4', '2', 'SI', 'https://loremflickr.com/640/480', 1) 

-- Verificación de existencia de ambos productos
SELECT * FROM Productos WHERE nombre IN ('producto', 'otro producto');



-- Modificación de un producto
go
-- Procedimiento almacenado para modificar un producto
CREATE PROCEDURE Modificar_Producto ( --Se declaran todos los parámetros que recibirá el procedimiento, que son los atributos de un producto
@id_producto int,
@nombre varchar (100),
@precio float,
@stock int,
@stock_minimo int,
@activo varchar (2),
@imagen varchar (250),
@id_categoria int
) as begin 
begin try -- se intenta comenzar la transacción

-- se inicia la transacción, donde se declara el UPDATE para un producto existente, buscándolo por su ID.
begin transaction modificar

UPDATE Productos 
            SET    nombre = @nombre,
                   precio = @precio,
                   stock = @stock,
                   stock_minimo = @stock_minimo,
				   activo = @activo,
				   imagen = @imagen,
				   id_categoria = @id_categoria
            WHERE  id_producto = @id_producto

commit transaction modificar
end try
begin catch -- en el caso de que la transacción falle, se activa el bloque catch, que ejecuta el rollback que devuelve la base al estado anterior
rollback transaction modificar
 DECLARE @ErrorMessage NVARCHAR(4000);
    SET @ErrorMessage = ERROR_MESSAGE();
    RAISERROR(@ErrorMessage, 16, 1);
end catch
end

-- actualización explicíta de un producto
UPDATE Productos SET nombre = 'nombre actualizado' WHERE id_producto = 1;

-- prueba de actualización a través del procedimiento Modificar_Producto
EXECUTE Modificar_Producto 2, 'segunda actualizacion', 4544, 6, 2, 'SI', 'https://loremflickr.com/640/480', 2;

-- Verificación de modificación de productos
SELECT * FROM Productos WHERE id_producto IN (1,2);


-- Eliminación de un producto --
go
-- Procedimiento almacenado para eliminar un producto
CREATE PROCEDURE Eliminar_Producto ( --Se declaran el parámetro que recibirá el procedimiento, que es el ID del producto a eliminar
@id_producto int
) as begin 
begin try -- se intenta comenzar la transacción

-- se inicia la transacción, donde se declara el DELETE para un producto existente, buscándolo por su ID.
begin transaction baja

DELETE FROM Productos
            WHERE  id_producto = @id_producto

commit transaction baja
end try
begin catch -- en el caso de que la transacción falle, se activa el bloque catch, que ejecuta el rollback que devuelve la base al estado anterior
rollback transaction baja
 DECLARE @ErrorMessage NVARCHAR(4000);
    SET @ErrorMessage = ERROR_MESSAGE();
    RAISERROR(@ErrorMessage, 16, 1);
end catch
end

-- Eliminación explicíta de un producto
DELETE FROM Productos WHERE id_producto = 11;

-- Prueba de eliminación a través del procedimiento Eliminar_Producto
EXECUTE Eliminar_Producto 10;

-- Verificación de la inexistencia de ambos productos
SELECT * FROM Productos WHERE id_producto IN (10, 11, 12);


-- FUNCIONES --
go
-- Función escalar para verificar si el stock actual de un producto sobrepasa el stock mínimo fijado para éste
CREATE FUNCTION VerificarStockMinimo (@id_producto INT) -- declaramos los parámetros que se van a usar, en este caso el ID para buscar el producto a analizar
RETURNS BIT --declaramos el tipo de dato que va a devolver la función
AS
BEGIN
    DECLARE @resultado BIT; -- declaramos el dato para contener el resultado
	-- declaramos la instrucción
    SELECT @resultado = CASE 
                          WHEN stock <= stock_minimo THEN 1
                          ELSE 0
                        END
    FROM Productos
    WHERE id_producto = @id_producto;

    RETURN @resultado; -- retornamos el resultado
END;
go

-- Instrucción explicíta para verificar el stock de un producto
SELECT CASE
			WHEN stock <= stock_minimo THEN 1
            ELSE 0
			END AS 'Verificación stock'
 FROM Productos
 WHERE id_producto =2;

-- Invocación a la función VerificarStockMinimo
SELECT dbo.VerificarStockMinimo(2) AS 'Verificación stock';

go

-- Función escalar para calcular el subtotal de una venta, guardada en la tabla Factura
CREATE FUNCTION CalcularSubtotalFactura (@id_factura INT)  -- declaramos los parámetros que se van a usar, en este caso el ID de la factura a calcular
RETURNS FLOAT  --declaramos el tipo de dato que va a devolver la función
AS
BEGIN
    DECLARE @subtotal FLOAT;  -- declaramos el dato para contener el resultado
	-- declaramos la instrucción
    SELECT @subtotal = SUM(pd.subtotal)
    FROM producto_detalle pd
    JOIN Factura f ON f.id_producto_detalle = pd.id_producto_detalle
    WHERE f.id_factura = @id_factura;

    RETURN ISNULL(@subtotal, 0);
END;
go

-- Instrucción explicíta para calcular el subtotal de una factura
SELECT  SUM(pd.subtotal) AS subtotal
    FROM producto_detalle pd
    JOIN Factura f ON f.id_producto_detalle = pd.id_producto_detalle
    WHERE f.id_factura = 5;

-- Invocación a la función CalcularSubtotalFactura
SELECT dbo.CalcularSubtotalFactura(5) AS 'Subtotal factura';

go

-- Función de tabla para listar todas las facturas con sus correspondientes detalles
CREATE FUNCTION ListarFacturasConDetalles ()
RETURNS TABLE -- se declara el tipo table para el valor de retorno
AS
RETURN -- se declara la instrucción que se retornará como resultado
(
    SELECT 
        f.id_factura,
        f.total,
        f.fecha,
        u.nombre AS nombre_usuario,
        u.apellido AS apellido_usuario,
        u.email AS email_usuario,
        pd.id_producto,
        p.nombre AS nombre_producto,
        pd.cantidad,
        pd.subtotal,
        mp.metodo AS metodo_pago
    FROM Factura f
    JOIN Usuarios u ON f.id_usuario = u.id_usuario
    JOIN producto_detalle pd ON f.id_producto_detalle = pd.id_producto_detalle
    JOIN Productos p ON pd.id_producto = p.id_producto
    JOIN metodos_de_pagos mp ON f.id_metodo_pago = mp.id_metodo_pago
);
go 

-- Instrucción explicíta para listar todas las facturas con sus correspondientes detalles
SELECT 
        f.id_factura,
        f.total,
        f.fecha,
        u.nombre AS nombre_usuario,
        u.apellido AS apellido_usuario,
        u.email AS email_usuario,
        pd.id_producto,
        p.nombre AS nombre_producto,
        pd.cantidad,
        pd.subtotal,
        mp.metodo AS metodo_pago
    FROM Factura f
    JOIN Usuarios u ON f.id_usuario = u.id_usuario
    JOIN producto_detalle pd ON f.id_producto_detalle = pd.id_producto_detalle
    JOIN Productos p ON pd.id_producto = p.id_producto
    JOIN metodos_de_pagos mp ON f.id_metodo_pago = mp.id_metodo_pago

-- Invocación a la función ListarFacturasConDetalles
SELECT * FROM dbo.ListarFacturasConDetalles();