use Proyecto_Base_De_Datos

-- Índices de la tabla Contacto

CREATE INDEX Contacto_Email ON Contacto(email);
-- Índice no clustered en la columna `email` de la tabla `Contacto`.
-- Optimiza las consultas que buscan contactos específicos por correo electrónico.
-- Útil para mejorar el rendimiento en filtros como `WHERE email = 'example@example.com'`.

CREATE INDEX Contacto_Respondido ON Contacto(respondido);
-- Índice no clustered en la columna `respondido` de la tabla `Contacto`.
-- Optimiza las consultas que filtran contactos por estado de respuesta (`respondido = 'si'` o `respondido = 'no'`).
-- Mejora la eficiencia en búsquedas y filtrados de contactos según el estado de respuesta.

-- Índices de la tabla Productos

CREATE INDEX Productos_IdCategoria ON Productos(id_categoria);
-- Índice no clustered en la columna `id_categoria` de la tabla `Productos`.
-- Facilita las consultas y uniones (`JOIN`) entre `Productos` y `Categorias` basadas en `id_categoria`.
-- Acelera los tiempos de respuesta para consultas que buscan productos de una categoría específica.

CREATE INDEX Productos_Activo ON Productos(activo);
-- Índice no clustered en la columna `activo` de la tabla `Productos`.
-- Optimiza las consultas que filtran productos según su estado (`activo = 'si'` o `activo = 'no'`).
-- Mejora el rendimiento de consultas que solo buscan productos activos o inactivos.

-- Índices de la tabla Usuarios

CREATE INDEX Usuarios_IdPerfil ON Usuarios(id_perfil);
-- Índice no clustered en la columna `id_perfil` de la tabla `Usuarios`.
-- Optimiza las consultas y uniones (`JOIN`) entre `Usuarios` y `Perfiles` que utilizan la columna `id_perfil`.
-- Facilita las búsquedas de usuarios en función de su perfil y mejora el rendimiento en filtros por perfil.

CREATE INDEX Usuarios_Estado ON Usuarios(estado);
-- Índice no clustered en la columna `estado` de la tabla `Usuarios`.
-- Mejora las consultas que filtran usuarios según su estado (`estado = 'activo'` o `estado = 'inactivo'`).
-- Incrementa la velocidad en consultas que buscan usuarios en un estado específico.

-- Índices de la tabla producto_detalle

CREATE INDEX ProductoDetalle_IdProducto ON producto_detalle(id_producto);
-- Índice no clustered en la columna `id_producto` de la tabla `producto_detalle`.
-- Facilita las uniones (`JOIN`) entre `producto_detalle` y `Productos` basadas en la columna `id_producto`.
-- Mejora el rendimiento en consultas que buscan detalles de productos específicos.

-- Índices de la tabla Factura

CREATE INDEX Factura_IdUsuario ON Factura(id_usuario);
-- Índice no clustered en la columna `id_usuario` de la tabla `Factura`.
-- Optimiza las consultas y uniones (`JOIN`) entre `Factura` y `Usuarios` que usan la columna `id_usuario`.
-- Acelera consultas que buscan facturas asociadas a un usuario específico.

CREATE INDEX Factura_IdProductoDetalle ON Factura(id_producto_detalle);
-- Índice no clustered en la columna `id_producto_detalle` de la tabla `Factura`.
-- Facilita las consultas y uniones entre `Factura` y `producto_detalle` basadas en `id_producto_detalle`.
-- Mejora la eficiencia en búsquedas de facturas que contienen detalles de productos específicos.

CREATE INDEX Factura_IdMetodoPago ON Factura(id_metodo_pago);
-- Índice no clustered en la columna `id_metodo_pago` de la tabla `Factura`.
-- Optimiza consultas que filtran facturas por método de pago.
-- Acelera las búsquedas de facturas basadas en un método de pago específico, mejorando el rendimiento en filtros como `WHERE id_metodo_pago = X`.

-- Índices de la tabla envios

CREATE INDEX Envios_IdFactura ON envios(id_factura);
-- Índice no clustered en la columna `id_factura` de la tabla `envios`.
-- Facilita las consultas y uniones (`JOIN`) entre `envios` y `Factura` basadas en la columna `id_factura`.
-- Mejora el rendimiento en consultas que buscan envíos relacionados con una factura específica.


--  1) Listar todos los productos con su categoría
SELECT p.nombre AS Producto, c.descripcion_categoria AS Categoria
FROM Productos p
JOIN Categorias c ON p.id_categoria = c.id_categoria;



--  2) Obtener detalles de contacto que no han sido respondidos
SELECT nombre, apellido, email, consulta, fecha_consulta
FROM Contacto
WHERE respondido = 'no';