Informe de Manejo de Transacciones y Transacciones Anidadas en SQL Server

Introducción a las Transacciones en SQL Server
En SQL Server, una transacción es un conjunto de operaciones que se ejecutan de manera conjunta y deben considerarse como una unidad de trabajo. En términos generales, las transacciones son esenciales 
para preservar la coherencia y fiabilidad de la base de datos, ya que aseguran que las operaciones realizadas dentro de la transacción se completen en su totalidad o, de lo contrario, se reviertan si ocurre 
algún error. Esto significa que una transacción es un mecanismo que permite mantener la base de datos en un estado consistente, incluso frente a errores o fallas durante la ejecución de operaciones.

Para gestionar las transacciones, SQL Server implementa el modelo ACID, que establece cuatro propiedades fundamentales:

Atomicidad: Asegura que todas las operaciones dentro de la transacción se ejecuten en su totalidad o no se ejecuten en absoluto. Si ocurre un error, todos los cambios realizados por la transacción deben deshacerse, 
manteniendo la base de datos en un estado estable.

Consistencia: Garantiza que la base de datos pase de un estado válido a otro estado igualmente válido después de la ejecución de una transacción. Cualquier transacción debe preservar las reglas y restricciones de la 
base de datos.

Aislamiento: Establece que las transacciones deben ejecutarse sin interferir entre sí, asegurando que las operaciones dentro de una transacción no afecten o sean afectadas por otras transacciones en curso. Este aspecto 
es crucial en entornos de alta concurrencia.

Durabilidad: Asegura que una vez que una transacción se confirma, sus cambios se mantienen permanentemente en la base de datos, incluso frente a fallas de sistema o apagados inesperados.


Tipos de Transacciones en SQL Server

Transacciones Implícitas: Inician automáticamente una nueva transacción cada vez que se ejecuta una instrucción que modifica datos, sin necesidad de comandos explícitos para comenzar la transacción. El sistema trata 
cada instrucción DML (Data Manipulation Language) como una transacción separada.

Transacciones Explícitas: Requieren que el usuario comience y termine explícitamente la transacción mediante comandos específicos (como BEGIN TRANSACTION, COMMIT TRANSACTION y ROLLBACK TRANSACTION).

Transacciones Anidadas: Son transacciones que se inician dentro del contexto de una transacción en curso. SQL Server permite manejar múltiples niveles de transacciones, donde una transacción principal contiene una o 
más sub-transacciones.

Transacciones Anidadas en SQL Server
Las transacciones anidadas permiten estructurar y dividir una operación compleja en varias sub-operaciones, cada una de las cuales puede considerarse como una transacción en sí misma. Esto facilita la modularización y 
el control de errores. Sin embargo, las transacciones anidadas en SQL Server funcionan como una única transacción, en el sentido de que el resultado final depende del estado de todas las sub-transacciones.

Funcionamiento y Propósito de las Transacciones Anidadas
Control Jerárquico: Al utilizar transacciones anidadas, se puede establecer un control jerárquico donde cada sub-transacción pertenece a una transacción de nivel superior. Esto permite que las sub-transacciones se 
integren en la transacción principal, facilitando la estructura y modularidad del código.

Administración de Operaciones Complejas: En situaciones donde una operación implica varias acciones separadas que pueden necesitarse revertir parcialmente, las transacciones anidadas permiten una mayor flexibilidad. 
Por ejemplo, una operación financiera puede necesitar realizar varios movimientos en diferentes cuentas, y cada movimiento puede representarse mediante una sub-transacción.

Manejo Centralizado de Errores: Las transacciones anidadas permiten que el sistema maneje los errores de manera centralizada. En el caso de que una sub-transacción falle, el sistema puede elegir entre revertir solo 
esa operación o revertir toda la transacción principal, dependiendo del diseño de los niveles de transacciones.

