use Proyecto_Base_De_Datos

-- �ndices de la tabla Contacto

CREATE INDEX Contacto_Email ON Contacto(email);
-- �ndice no clustered en la columna `email` de la tabla `Contacto`.
-- Optimiza las consultas que buscan contactos espec�ficos por correo electr�nico.
-- �til para mejorar el rendimiento en filtros como `WHERE email = 'example@example.com'`.

CREATE INDEX Contacto_Respondido ON Contacto(respondido);
-- �ndice no clustered en la columna `respondido` de la tabla `Contacto`.
-- Optimiza las consultas que filtran contactos por estado de respuesta (`respondido = 'si'` o `respondido = 'no'`).
-- Mejora la eficiencia en b�squedas y filtrados de contactos seg�n el estado de respuesta.

-- �ndices de la tabla Productos

CREATE INDEX Productos_IdCategoria ON Productos(id_categoria);
-- �ndice no clustered en la columna `id_categoria` de la tabla `Productos`.
-- Facilita las consultas y uniones (`JOIN`) entre `Productos` y `Categorias` basadas en `id_categoria`.
-- Acelera los tiempos de respuesta para consultas que buscan productos de una categor�a espec�fica.

CREATE INDEX Productos_Activo ON Productos(activo);
-- �ndice no clustered en la columna `activo` de la tabla `Productos`.
-- Optimiza las consultas que filtran productos seg�n su estado (`activo = 'si'` o `activo = 'no'`).
-- Mejora el rendimiento de consultas que solo buscan productos activos o inactivos.

-- �ndices de la tabla Usuarios

CREATE INDEX Usuarios_IdPerfil ON Usuarios(id_perfil);
-- �ndice no clustered en la columna `id_perfil` de la tabla `Usuarios`.
-- Optimiza las consultas y uniones (`JOIN`) entre `Usuarios` y `Perfiles` que utilizan la columna `id_perfil`.
-- Facilita las b�squedas de usuarios en funci�n de su perfil y mejora el rendimiento en filtros por perfil.

CREATE INDEX Usuarios_Estado ON Usuarios(estado);
-- �ndice no clustered en la columna `estado` de la tabla `Usuarios`.
-- Mejora las consultas que filtran usuarios seg�n su estado (`estado = 'activo'` o `estado = 'inactivo'`).
-- Incrementa la velocidad en consultas que buscan usuarios en un estado espec�fico.

-- �ndices de la tabla producto_detalle

CREATE INDEX ProductoDetalle_IdProducto ON producto_detalle(id_producto);
-- �ndice no clustered en la columna `id_producto` de la tabla `producto_detalle`.
-- Facilita las uniones (`JOIN`) entre `producto_detalle` y `Productos` basadas en la columna `id_producto`.
-- Mejora el rendimiento en consultas que buscan detalles de productos espec�ficos.

-- �ndices de la tabla Factura

CREATE INDEX Factura_IdUsuario ON Factura(id_usuario);
-- �ndice no clustered en la columna `id_usuario` de la tabla `Factura`.
-- Optimiza las consultas y uniones (`JOIN`) entre `Factura` y `Usuarios` que usan la columna `id_usuario`.
-- Acelera consultas que buscan facturas asociadas a un usuario espec�fico.

CREATE INDEX Factura_IdProductoDetalle ON Factura(id_producto_detalle);
-- �ndice no clustered en la columna `id_producto_detalle` de la tabla `Factura`.
-- Facilita las consultas y uniones entre `Factura` y `producto_detalle` basadas en `id_producto_detalle`.
-- Mejora la eficiencia en b�squedas de facturas que contienen detalles de productos espec�ficos.

CREATE INDEX Factura_IdMetodoPago ON Factura(id_metodo_pago);
-- �ndice no clustered en la columna `id_metodo_pago` de la tabla `Factura`.
-- Optimiza consultas que filtran facturas por m�todo de pago.
-- Acelera las b�squedas de facturas basadas en un m�todo de pago espec�fico, mejorando el rendimiento en filtros como `WHERE id_metodo_pago = X`.

-- �ndices de la tabla envios

CREATE INDEX Envios_IdFactura ON envios(id_factura);
-- �ndice no clustered en la columna `id_factura` de la tabla `envios`.
-- Facilita las consultas y uniones (`JOIN`) entre `envios` y `Factura` basadas en la columna `id_factura`.
-- Mejora el rendimiento en consultas que buscan env�os relacionados con una factura espec�fica.


--  1) Listar todos los productos con su categor�a
SELECT p.nombre AS Producto, c.descripcion_categoria AS Categoria
FROM Productos p
JOIN Categorias c ON p.id_categoria = c.id_categoria;



--  2) Obtener detalles de contacto que no han sido respondidos
SELECT nombre, apellido, email, consulta, fecha_consulta
FROM Contacto
WHERE respondido = 'no';