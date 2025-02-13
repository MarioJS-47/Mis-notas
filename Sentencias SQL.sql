-- Crear base de datos
CREATE DATABASE pedidos;

-- Usar base de datos
USE pedidos; 

--Crear tabla
CREATE TABLE refacciones(    
    codigo INT PRIMARY KEY,  
    descripcion VARCHAR(200),
    categoria VARCHAR(20),   
    precio DECIMAL(10,2) -- Cantidad de cifras enteras / Cantidad de cifras decimales
);                           

-- Inserccion de datos                      
INSERT INTO refacciones (codigo, descripcion, categoria, precio) VALUES (40061762, 'Cable ethernet RJ45 a RJ45 - 10m', 'electrica', 250.20);                                      
                                                                                                        
-- Consulta de datos                                                                                           
SELECT * FROM refacciones;                                                                                     
                                                                                                               
-- Consulta de columnas especificas                                                                            
SELECT codigo, precio FROM refacciones;                                                                        
                                                                                                               
-- Consulta con alias                                                                                          
SELECT codigo AS Mi_codigo FROM refacciones;                                                                   
                                                                                                               
-- Consulta con criterio                                                                                       
SELECT * FROM refacciones WHERE categoria = 'electrica';                                                       
                                                                                                               
-- Consulta con doble criterio                                                                                 
SELECT * FROM refacciones WHERE categoria IN ('electrica','neumatica');                                        
                                                                                                               
-- Consulta con exepcion                                                                                       
SELECT * FROM refacciones WHERE NOT categoria = 'neumatica';                                                   
                                                                                                               
-- Consulta LIKE para buscar registros que contengan palabra en cualquier lugar del registro                   
SELECT * FROM refacciones WHERE descripcion LIKE '%ethernet%';                                                 
                                                                                                               
-- Consulta LIKE para buscar registros que terminen con la palabra indicada                                    
SELECT * FROM refacciones WHERE descripcion LIKE '%ethern';

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
