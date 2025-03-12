-- Crear base de datos
CREATE DATABASE nombre_database;

-- Usar base de datos
USE nombre_database; 

--Crear tabla
CREATE TABLE nombre_tabla(    
    columna_numero INT,  
    columna_texto1 VARCHAR(200),
    columna_texto2 VARCHAR(20),   
    columna_decimal DECIMAL(10,2), -- Cantidad de cifras enteras / Cantidad de cifras decimales
    PRIMARY KEY(columna_numero)
) ENGINE = InnoDB; -- Motor de almacenamiento habilitado para uso de llaves foraneas

-- Renombrar tabla
RENAME TABLE nombre_tabla TO nuevo_nombre;

-- Inserccion de datos                      
INSERT INTO nombre_tabla (columna1, columna2, columna3, columna4) VALUES (40061762, 'Cable ethernet RJ45 a RJ45 - 10m', 'electrica', 250.20);                                      
                                                                                                        
-- Consulta de datos                                                                                           
SELECT * FROM nombre_tabla;                                                                                     
                                                                                                               
-- Consulta de columnas especificas                                                                            
SELECT columna1, columna2 FROM nombre_tabla;                                                                        
                                                                                                               
-- Consulta con alias                                                                                          
SELECT nombre_columna AS alias_columna FROM nombre_tabla;                                                                   
                                                                                                               
-- Consulta con criterio                                                                                       
SELECT * FROM nombre_tabla WHERE nombre_columna = 'criterio';                                                       
                                                                                                               
-- Consulta con doble criterio                                                                                 
SELECT * FROM nombre_tabla WHERE nombre_columna IN ('criterio1','criterio2');                                        
                                                                                                               
-- Consulta con exepcion                                                                                       
SELECT * FROM nombre_tabla WHERE NOT nombre_columna = 'criterio';                                                   
                                                                                                               
-- Consulta LIKE para buscar registros que contengan palabra en cualquier lugar del registro                   
SELECT * FROM nombre_tabla WHERE nombre_columna LIKE '%criterio%';                                                 
                                                                                                               
-- Consulta LIKE para buscar registros que terminen con la palabra indicada                                    
SELECT * FROM nombre_tabla WHERE nombre_columna LIKE '%criterio';

-- Realizar consulta de registros unicos descartando repetidos
SELECT DISTINCT * FROM nombre_tabla;

-- Consultar todo de tabla limitando a 4 primeros registros
SELECT * FROM nombre_tabla LIMIT 4;

-- Consultar listado limitado a solo visualizar de registro 4 al 10
SELECT * FROM nombre_tabla LIMIT 4,10;

-- Consulta agrupacion de datos basado en COUNT (Conteo), es posible aplicar operaciones con MIN, MAX, AVG, SUM
SELECT nombre_columna, COUNT(nombre_columna2) FROM  nombre_tabla
GROUP BY nombre_columna;

-- Aplicar operacion total de la tabla
SELECT SUM(nombre_columna) FROM nombre_tabla;

-- Consulta de total por GROUP BY
SELECT nombre_columna, count(*) FROM nombre_tabla
GROUP BY nombre_columna2;

-- Consulta suma de precios por categoria de refacciones, agrupando por categoria, teniendo que la suma de precios sea mayor a 100
SELECT categoria, SUM(precio)AS precio_categoria FROM  refacciones
GROUP BY categoria
HAVING precio_categoria > 100;

-- Consultar empleando clasificacion de registros
SELECT Codigo
CASE
  WHEN precio >= 500 AND precio <= 600 THEN 'Costoso'
  WHEN precio >= 400 AND precio <= 500 THEN 'Precio regular'
  ELSE 'Precio bajo'
END
FROM refacciones

-- Uniones JOIN

-- Unir 2 o mas tablas a la vez a travez de un campo en comun
SELECT A.nombre, B.profesion FROM TABLA_IZQ A
INNER JOIN
TABLA_DER B
ON A.ID = B.ID

-- Mantiene todos los registros de la tabla de la izquierda y devuelve unicamente los correspondientes de la derecha
SELECT A.nombre, B.profesion FROM TABLA_IZQ A
LEFT JOIN
TABLA_DER B
ON A.ID = B.ID

-- Mantiene todos los registros de la tabla de la derecha y devuelve unicamente los correspondientes de la izquierda
SELECT A.nombre, B.profesion FROM TABLA_IZQ A
RIGHT JOIN
TABLA_DER B
ON A.ID = B.ID

-- Mantiene y devuelve todos los registros de las tablas
SELECT A.nombre, B.profesion FROM TABLA_IZQ A
FULL JOIN
TABLA_DER B
ON A.ID = B.ID

-- CROSS JOIN: Devuelve el producto cartesiano de los registros de las tablas
SELECT A.nombre, B.profesion FROM TABLA_IZQ A, TABLA_DER B

-- Permite unir 2 o mas tablas(Implictamente ejecuta DISTINCT) el numero de campos de las tablas debe ser igual (Mismos campos y mismos tipos)
-- <Sentencia 1>
    UNION
-- <Sentencia 2>
    
--Cambiar tipo de dato a columna
ALTER TABLE refacciones                
MODIFY COLUMN descripcion TEXT(200);   
                                       
-- Eliminar registro de tabla          
DELETE FROM refacciones                
WHERE codigo = 40061800;               
                                       
-- Actualizar registro de tabla        
UPDATE refacciones                     
SET precio = 350.3                     
WHERE codigo = 40061762;               

-- Creacion de una llave foranea
ALTER TABLE orders ADD CONSTRAINT FK_code_catalog
FOREIGN KEY (CODE) REFERENCES catalog(CODE);

-- Marca el inicio de una secuencia de operaciones en la base de datos que deben tratarse como una sola unidad.
START TRANSACTION;

-- Deshace todos los cambios realizados dentro de la transacción.
ROLLBACK:
    
-- Confirma y guarda permanentemente todos los cambios realizados dentro de la transacción.
COMMIT;

-- Estructura de un Procedure
DELIMITER //
CREATE PROCEDURE nombre_procedure()
BEGIN
    DECLARE texto VARCHAR(10) DEFAULT 'Hola';
    SELECT texto;
END //
DELIMITER

-- Llamado de procedimiento
CALL nombre_procedure;

