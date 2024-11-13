# PRESENTACIÓN Proyecto de Estudio  “Gestión y Análisis de Bases de Datos implementadas en Aplicaciones Web”


**Asignatura**: Bases de Datos I (FaCENA-UNNE)

**Integrantes**:
 - Ghio, Giovanni José
 - Durand, Emilio
 - Fernández, Vicente Gregorio
 - Salinas Sanette, Morena Irupé

**Año**: 2024

## CAPÍTULO I: INTRODUCCIÓN

### Definición o planteamiento del problema

El siguiente Proyecto de Estudio tiene como objetivo consolidar los conocimientos teóricos y prácticos adquiridos en la Cátedra, a través del desarrollo e implementación de una Base de Datos Relacional, complementada con una investigación conceptual de las técnicas utilizadas.

Durante el proceso de creación de este proyecto, nos proponemos responder a preguntas cómo, ¿cuáles son los beneficios de la utilización de Gestores de Bases de Datos en el ámbito empresarial? ¿Cómo debemos delimitar el alcance de un sistema, de forma que cumpla con los niveles de optimización y funcionalidad esperados? ¿Cómo las nuevas tecnologías nos ayudan durante este proceso?

### Caso de estudio

El caso de estudio que elegimos para este trabajo es una Aplicación Web, diseñada para desempeñarse como una Gestión de Ventas. 
Específicamente, tal sistema se ocupa de:
    - gestionar los Usuarios que se registran en la página, sean clientes o los propios administradores definidos por la Empresa;
    - gestionar los productos ofrecidos al público y la información sobre cada uno;
    - las ventas generadas, pudiendo ser accedidas tanto por el comprador como los administradores de la página;
    - controlar los diferentes métodos de pago disponibles y correspondiente envío al comprador
    - posibilitar el envío de consultas para cualquier visitante de la página.
    
Definimos que el alcance de los envíos se extiende hasta el nivel nacional; por otro lado, establecemos que no se contemplan funciones que permitan a los usuarios dejar reseñas para los productos comprados, ni la posibilidad de devoluciones de los envíos realizados, como así tampoco se tiene en cuenta la gestión de proveedores de la empresa, ni las compras que se efectúen a través de ellos. En cuanto a los métodos de pago, el sistema limita a la elección de un único medio de pago por cada compra.

## CAPITULO II: MARCO CONCEPTUAL O REFERENCIAL

**TEMA 1 "Manejo de permisos a nivel de usuarios de base de datos"**
	Logins: Entidades de seguridad a nivel de servidor que permiten la autenticación de usuarios. Pueden ser de tres tipos: SQL Server, Windows, y Certificados/Claves Asimétricas.
Usuarios: Entidades de seguridad a nivel de base de datos asociadas a logins. Determinan qué acciones puede realizar un usuario dentro de una base de datos.
Roles: Agrupan permisos, facilitando la asignación y gestión de acceso. Existen roles predefinidos (como sysadmin, db_owner) y personalizados.
Permisos: Controlan las operaciones que los usuarios pueden realizar en la base de datos. Se pueden asignar directamente a usuarios o a roles.

**TEMA 2 "Procedimientos almacenados y funciones creadas por el usuario"**
Procedimientos Almacenados: Son conjuntos de instrucciones SQL predefinidas que se pueden ejecutar bajo demanda. Ofrecen varios beneficios:

   Reducción del tráfico de red: Se ejecutan en un solo bloque de código en el servidor.
   Mayor seguridad: Permiten ejecutar instrucciones específicas sin dar acceso completo a los datos, ocultando el código y protegiendo contra inyecciones maliciosas.
   Reutilización de código: Reducen la complejidad y la inconsistencia del código.
   Mejor rendimiento: Se compilan una vez y reutilizan el plan de ejecución para optimizar futuras ejecuciones.
   Tipos:
    	Creados por el usuario: Definidos según las necesidades del sistema.
    	Temporales: Visibles solo durante la sesión activa.
    	De sistema: Proporcionados por SQL Server para operaciones internas.

Funciones Definidas por el Usuario (UDF): Son rutinas que aceptan parámetros y devuelven un valor o conjunto de resultados. Sus ventajas incluyen:

   Programación modular: Permiten reutilizar código almacenado.
   Mejora del rendimiento: Se ejecutan sin necesidad de ser analizadas nuevamente.
   Reducción del tráfico de red: Agrupan resultados en menos filas.
   Tipos:
    	Escalares: Devuelven un solo valor.
    	De tabla: Devuelven un conjunto de resultados tipo tabla.
    	De sistema: Funciones proporcionadas por SQL Server para tareas específicas.

**TEMA 3 "Manejo de Transacciones y Transacciones Anidadas en SQL Server"**
	Generación de Índices: Los índices son estructuras que mejoran la eficiencia en la búsqueda de datos. Se crean en columnas clave identificadas en las cláusulas WHERE, JOIN, ORDER BY o GROUP BY. Los tipos principales son:
    	Índice Clustered (Agrupado): Organiza físicamente los datos en el disco. Solo puede haber uno por tabla.
    	Índice Non-clustered (No Agrupado): Estructura separada con punteros a las filas reales. Una tabla puede tener varios.

   Propósito de los Índices: Aceleran las consultas al permitir el acceso directo a los registros, evitando un escaneo completo de la tabla.

   Ventajas:
    	Mejora la velocidad de consultas y uniones (JOIN).
    	Acelera la clasificación y agrupación de datos.
    	Reduce el uso de recursos (CPU, memoria).
    	Mejora la escalabilidad en grandes volúmenes de datos.

   Desventajas:
    	Los índices pueden ralentizar las operaciones de escritura (inserciones, actualizaciones y eliminaciones) debido a la necesidad de actualizarlos.

El uso de índices debe ser estratégico, equilibrando el beneficio en lecturas con el impacto en las escrituras.

**TEMA 4 "Manejo de Transacciones y Transacciones Anidadas en SQL Server"**
Transacciones: Conjunto de operaciones ejecutadas como una unidad. Garantizan la coherencia mediante el modelo ACID (Atomicidad, Consistencia, Aislamiento, Durabilidad).
Tipos de transacciones:

   Implícitas: Iniciadas automáticamente por SQL Server con operaciones DML.
   Explícitas: Iniciadas por el usuario usando comandos específicos.
   Anidadas: Transacciones dentro de otras, permitiendo control jerárquico y manejo modular de errores.

Ventajas: Mejoran la seguridad y la integridad de los datos, permitiendo la reversión de operaciones en caso de error.

## CAPÍTULO III: METODOLOGÍA SEGUIDA 

El trabajo se llevó a cabo en varias etapas que facilitaron una ejecución ordenada y eficiente del proyecto. A continuación se describen las principales fases del proceso:

Investigación Inicial: Se realizó una revisión exhaustiva de la página web ya creada en Taller 1, llamada 0325. Este análisis permitió identificar las funcionalidades existentes y las necesidades de la aplicación. A partir de esta base, se definieron las entidades necesarias para la gestión de ventas y se establecieron los requerimientos específicos de la Base de Datos.

Definición de Requerimientos: Se identificaron los requerimientos específicos de la aplicación de Gestión de Ventas. Esto incluyó definir las entidades clave, relaciones y atributos necesarios para el correcto funcionamiento del sistema.

Modelado de la Base de Datos: Utilizando ERD Plus, se creó un Diagrama Entidad-Relación (ER) que representó gráficamente la estructura de la Base de Datos. Este diagrama ayudó a visualizar las interacciones entre las distintas entidades y a garantizar que todos los aspectos del sistema estuvieran contemplados.
Implementación en SQL Server: Con el modelo aprobado, se procedió a la creación de las tablas en SQL Server Management Studio. Se definieron las estructuras de las tablas, claves primarias y foráneas, así como las restricciones necesarias para asegurar la integridad de los datos.

b. Herramientas (Instrumentos y procedimientos)
Para la recolección y tratamiento de la información se utilizaron las siguientes herramientas y procedimientos:

ERD Plus: Esta herramienta fue fundamental para el modelado de la Base de Datos. Permite crear diagramas ER de manera intuitiva, lo que facilitó la visualización de la estructura de la Base de Datos y las relaciones entre las diferentes entidades.

SQL Server Management Studio: Se utilizó para la creación, gestión y consulta de la Base de Datos. Esta herramienta permitió implementar las tablas, definir relaciones, y ejecutar consultas SQL para manipular y extraer información de manera efectiva.




## CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS 

Luego de la investigación y análisis de la información, se presentan los siguientes resultados.


### Diagrama relacional
![diagrama_relacional](https://github.com/morenassanette/basesdedatos_proyecto_estudio_Grupo11/blob/main/doc/ERD_Proyecto.png)

### Diccionario de datos

Acceso al documento [PDF](doc/Diccionario%20de%20datos.pdf) del diccionario de datos.


### Desarrollo TEMA 1 "----"

### Desarrollo TEMA 1 "Manejo de permisos a nivel de usuarios de base de datos"

Se presenta el informe teórico y los scripts para la realización de las tareas de análisis de manejo de permisos.

> Acceder a la siguiente carpeta para la descripción completa del tema [scripts-> tema_1](script/Tema01_Manejo_de_permisos_a_nivel_de_usuarios_de_base_de_datos)

### Desarrollo TEMA 2 "Procedimientos almacenados y funciones"

Se presenta el informe teórico y los scripts para la realización de las tareas de creación y análisis de procedimientos y funciones almacenadas.

> Acceder a la siguiente carpeta para la descripción completa del tema [scripts-> tema_2](script/tema02_Procedimientos_almacenados_y_funciones)

### Desarrollo TEMA 3 "Optimización de consultas a través de índices"

Se presenta el informe teórico y los scripts para la realización de las tareas de optimización de consultas a través de índices.

> Acceder a la siguiente carpeta para la descripción completa del tema [scripts-> tema_3](script/Tema3_script/Tema3_Optimización_de_consultas_a_través_de_índices)

### Desarrollo TEMA 4 "Manejo de transacciones y transacciones anidadas"

Se presenta el informe teórico y los scripts para la realización de las tareas de manejo de transacciones.

> Acceder a la siguiente carpeta para la descripción completa del tema [scripts-> tema_4](script/Tema3_script/script/Tema04_Manejo_de_transacciones_y_transacciones_anidadas)



## CAPÍTULO V: CONCLUSIONES
En este proyecto, Hemos llevado a cabo el diseño y la implementación de una base de datos para una página de ventas, abordando diversos aspectos fundamentales sobre la gestión, la optimización y la seguridad de su contenido.

Hemos aprendido e implementado cosas tales como la creación de una estructura sólida y eficiente,la implementación de un esquema de permisos que limita el acceso no autorizado y protege la privacidad de los datos, la automatización y optimización de tareas a través de los procedimientos almacenados,la optimización de las consultas mediante el uso de índices y a mantener la integridad de los datos durante su carga mediante el uso de transacciones.

Este trabajo nos permitió aplicar conceptos teóricos y nos ayudó a mejorar nuestras habilidades en el diseño y gestión de una base de datos,preparándonos para futuros desafíos en entornos laborales profesionales.




## BIBLIOGRAFÍA DE CONSULTA

 1. [Microsoft Learn](https://learn.microsoft.com/es-es/sql/?view=sql-server-ver16)
 2. Camuña Rodríguez, J. F. (2015). Lenguajes de definición y modificación de datos SQL (UF1472): ( ed.). Antequera, Málaga, Spain: IC Editorial. 

