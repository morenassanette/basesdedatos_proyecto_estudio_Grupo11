-- DEFINNICIÓN DEL MODELO DE DATOS

CREATE DATABASE Proyecto_Base_De_Datos;

USE Proyecto_Base_De_Datos;

CREATE TABLE Categorias
(
  id_categoria INT NOT NULL IDENTITY,
  descripcion_categoria VARCHAR(100) NOT NULL,
  CONSTRAINT PK_CATEGORIAS_ID_CATEGORIA PRIMARY KEY (id_categoria)
);

CREATE TABLE Contacto
(
  id_contacto INT NOT NULL IDENTITY,
  nombre VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  consulta VARCHAR(250) NOT NULL,
  respuesta VARCHAR(250) NULL,
  respondido VARCHAR(2) NULL CONSTRAINT DF_CONTACTO_RESPONDIDO DEFAULT 'no',
  apellido VARCHAR(50) NOT NULL,
  CONSTRAINT PK_CONTACTO_ID_CONTACTO  PRIMARY KEY (id_contacto),
  CONSTRAINT CK_CONTACTO_RESPONDIDO CHECK (respondido in ('si','no')),
  UNIQUE (email)
);

CREATE TABLE Perfiles
(
  id_perfil INT NOT NULL,
  descripcion VARCHAR(50) NOT NULL,
  CONSTRAINT PK_PERFILES_ID_PERFILES  PRIMARY KEY (id_perfil)
);

CREATE TABLE metodos_de_pagos
(
  id_metodo_pago INT NOT NULL IDENTITY,
  metodo VARCHAR(50) NOT NULL,
  CONSTRAINT PK_METODOS_DE_PAGO_ID_METODOS_PAGO  PRIMARY KEY (id_metodo_pago)
);

CREATE TABLE Productos
(
  id_producto INT NOT NULL IDENTITY,
  nombre VARCHAR(100) NOT NULL,
  precio FLOAT NOT NULL,
  stock INT NOT NULL,
  stock_minimo INT NOT NULL,
  activo VARCHAR(2) NOT NULL CONSTRAINT DF_PRODUCTOS_ACTIVO DEFAULT 'si',
  imagen VARCHAR(250) NOT NULL,
  id_categoria INT NOT NULL,
  CONSTRAINT PK_PRODUCTOS_ID_PRODUCTOS  PRIMARY KEY (id_producto),
  CONSTRAINT FK_PRODUCTOS_ID_CATEGORIA FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria),
  CONSTRAINT CK_PRODUCTO_PRECIO CHECK (precio > 0),
  CONSTRAINT CK_PRODUCTO_STOCK_MINIMO CHECK (stock_minimo > 0),
  CONSTRAINT CK_PRODUCTO_STOCK CHECK (stock >= stock_minimo),
  CONSTRAINT CK_PRODUCTO_ACTIVO CHECK (activo in ('si','no'))

);

CREATE TABLE Usuarios
(
  id_usuario INT NOT NULL IDENTITY,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  usuario VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  pass VARCHAR(300) NOT NULL,
  estado VARCHAR(10) NOT NULL CONSTRAINT DF_USUARIOS_ESTADO DEFAULT 'activo',
  domicilio VARCHAR(100) NOT NULL,
  id_perfil INT NOT NULL CONSTRAINT DF_USUARIOS_IDPERFILES DEFAULT 2,
  DNI int NOT NULL,
  CONSTRAINT PK_USUARIOS_ID_USUARIO PRIMARY KEY (id_usuario),
  CONSTRAINT FK_USUARIOS_ID_PERFILES FOREIGN KEY (id_perfil) REFERENCES Perfiles(id_perfil),
  CONSTRAINT CK_USUARIOS_DNI CHECK (LEN(DNI) <= 8),
  CONSTRAINT CK_USUARIOS_ESTADO CHECK (estado in ('activo','inactivo')),
  UNIQUE (usuario),
  UNIQUE (email),
  UNIQUE (DNI)
);

CREATE TABLE Factura
(
  id_factura INT NOT NULL IDENTITY,
  total FLOAT NOT NULL,
  fecha DATE NOT NULL CONSTRAINT DF_FACTURA_FECHA DEFAULT GETDATE(),
  id_metodo_pago INT NOT NULL,
  id_usuario INT NOT NULL,
  CONSTRAINT PK_FACTURA_ID_FACTURA PRIMARY KEY (id_factura),
  CONSTRAINT FK_FACTURA_ID_METODOS_PAGO FOREIGN KEY (id_metodo_pago) REFERENCES metodos_de_pagos(id_metodo_pago),
  CONSTRAINT FK_FACTURA_ID_USUARIO FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE producto_detalle
(
  id_producto_detalle INT NOT NULL IDENTITY,
  cantidad INT NOT NULL,
  subtotal FLOAT NOT NULL,
  id_producto INT NOT NULL,
  id_factura INT NOT NULL,
  CONSTRAINT PK_PRODUCTO_DETALLE_ID_PRODUCTO_DETALLE PRIMARY KEY (id_producto_detalle),
  CONSTRAINT FK_PRODUCTO_DETALLE_ID_PRODUCTOS FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
  CONSTRAINT FK_PRODUCTO_DETALLE_ID_FACTURA FOREIGN KEY (id_factura) REFERENCES Factura(id_factura),
  CONSTRAINT CK_PRODUCTO_DETALLE_CANTIDAD CHECK (cantidad > 0)
);

CREATE TABLE envios
(
  id_envio INT NOT NULL IDENTITY,
  fecha_envio DATE NOT NULL CONSTRAINT DF_ENVIOS_FECHA_ENVIO DEFAULT GETDATE(),
  fecha_estimada_arribo DATE NOT NULL CONSTRAINT DF_ENVIOS_FECHA_ESTIMADA_ARRIBO DEFAULT DATEADD(DAY, 7, GETDATE()),
  id_factura INT NOT NULL,
  CONSTRAINT PK_ENVIOS_ID_ENVIO PRIMARY KEY (id_envio),
  CONSTRAINT FK_ENVIOS_ID_FACTURA FOREIGN KEY (id_factura) REFERENCES Factura(id_factura)
);
