PROCEDIMIENTOS ALMACENADOS 
-
Un procedimiento almacenado es un conjunto de una o varias instrucciones SQL. Estos procedimientos pueden ser llamados desde otras consultas e instrucciones,
y pueden tomar argumentos de entrada y mostrar valores como resultados. Entre los beneficios de su utilización, podemos nombrar:
1. Reducción del tráfico de red entre el cliente y el servidor, puesto que se ejecutan en un único lote de código;
2. Mayor seguridad, ya que permite a ciertos usuarios ejecutar instrucciones específicas sin tener permisos plenos sobre ellas, además de que permite ocultar el código interno,
   evitando así la inyección de código de usuarios malintencionados;
3. Reutilización de código, reduciendo la complejidad del código y la aparición de inconsistencias;
4. Mejor rendimiento, ya que  un procedimiento se compila la primera vez que se ejecuta y crea un plan de ejecución que vuelve a usarse en posteriores ejecuciones.

Existen tres tipos de procedimientos almacenados:
1. Creados por el usuario
2. Temporales (también creados por el usuario, pero son visibles únicamente mientras permanece activa la conxeión)
3. De sistema

FUNCIONES
-
Las funciones definidas por el usuario (UDF) son rutinas que aceptan parámetros, realizan una acción definida por una instrucción y/o operación,
y devuelven el resultado de esa acción como un valor. Este valor devuelto puede ser un valor escalar único o un conjunto de resultados. Las ventajas de utilizar UDFs son:
1. Permiten la programación modular, ya que una vez creadas, se almacenan y pueden ser llamadas cuando sea necesario;
2. Mejoría del rendimiento, al igual que los procedimientos almacenados, ya que no es necesario analizar la función cada vez que se la llama;
3. Reuducción del tráfico de red, ya que pueden contener varias expresiones escalares que luego son enviadas en un menor número de filas al cliente.

Hay tres tipos de UDF, siendo éstas:
1. Funciones escalares, que devuelven un sólo valor definido con la sentencia RETURNS;
2. Funciones de tabla, que no tienen cuerpo, y devuelven datos de tipo table;
3. Funciones de sistema

ANÁLISIS DE RENDIMIENTO DE PROCEDIMIENTOS Y FUNCIONES EN COMPARACIÓN CON INSTRUCCIONES SQL EXPLÍCITAS
-
Se presentan los análisis de rendimiento de las instrucciones ALTA PRODUCTO, BAJA PRODUCTO, CÁLCULO DE SUBTOTAL DE UNA FACTURA Y LISTA DE FACTURAS CON DETALLE. En todos
los casos, el Trial 1 corresponde al procedimiento almacenado o función, y el Trial 2 a la instrucción explícita equivalente a éstos.

Alta de un producto

![alta producto](https://github.com/user-attachments/assets/febe868b-f987-4666-b072-c89f04b03f8b)

Baja de un producto

![delete producto](https://github.com/user-attachments/assets/80ba92a6-17ed-4e71-b81d-700f320f3d01)

Para estos dos casos, podemos notar que las instrucciones directas generan un tiempo de espera del cliente mínimo a nulo, mientras que los procedimientos almacenados tardan
un poco más; en el caso del tiempo de espera del servidor los resultados varían más, pero tienden a un menor número en las funciones explícitas.
Considerando la baja complejidad de estas instrucciones, estos resultados pueden derivarse del hecho de no tener que realizar llamadas a otras funciones, aunque en volúmenes
de datos mucho mayores, estos resultados podrían invertirse.

Cálculo de subtotal de una factura

![subtotal sin funcion](https://github.com/user-attachments/assets/8fd2768c-ee61-4bde-928e-176dc335ef65)

Lista de facturas con detalles

![tabla detalles](https://github.com/user-attachments/assets/82ac5726-4d91-4d5e-9b11-ac962bb2a3bf)

En estos dos casos, en los que se usan funciones UDF, éstas generan mejores resultados en tiempos de espera del cliente que las instrucciones explícitas. En la tabla de
tiempos de la lista de detalles, los dos primeros intentos corresponden a la ejecución de la función UDF, y podemos notar que este tiempo de espera se reduce drásticamente
entre una y otra ejecución. Esto comprueba que el uso repetido de funciones mejora el rendimiento del programa, como así también, optimiza la conexión entre el cliente y el servidor.

Los resultados obtenidos en estas pruebas claramente no presentan grandes diferencias, pero como se denotó anteriormente, el beneficio de la utilización de estos elementos se
magnifica considerablemente al momento de aplicarlo en bases de datos con cantidades masivas de registros.
