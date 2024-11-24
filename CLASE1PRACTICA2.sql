--  1- Elimine la tabla "libros", si existe. 
DROP TABLE if EXISTS libros;

-- 2- Cree una tabla llamada "libros". Debe definirse con los siguientes campos: 
-- titulo (cadena de 20), autor (cadena de 30) y editorial (cadena de 15).

CREATE TABLE libros(
  titulo VARCHAR(20),
  autor VARCHAR(30),
  editorial VARCHAR(15)
);

--  3- Visualice las tablas existentes. 
SHOW TABLES;

-- 4- Visualice la estructura de la tabla "libros".
DESCRIBE libros;

-- 5- Ingrese los siguientes registros:
-- 'El aleph','Borges','Planeta';
-- 'Martin Fierro','Jose Hernandez','Emece';
-- 'Aprenda PHP','Mario Molina','Emece';

INSERT INTO libros
(titulo, autor, editorial) values 
('El aleph','Borges','Planeta'); 

INSERT INTO libros
(titulo, autor, editorial) values 
('Martin Fierro','Jose Hernandez','Emece'); 

INSERT INTO libros
(titulo, autor, editorial) values 
('Aprenda PHP','Mario Molina','Emece'); 


--  6- Muestre todos los registros.
SELECT titulo, autor, editorial FROM libros;
