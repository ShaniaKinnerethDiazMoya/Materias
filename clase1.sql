-- 1.- 
DROP TABLE IF EXISTS usuarios;
-- 2.-
CREATE TABLE usuarios(
  nombre VARCHAR(30),
  clave VARCHAR(10)
);
-- 3.-
DESCRIBE usuarios;
-- 4.-
INSERT INTO usuarios 
(nombre, clave) VALUES
("Leonardo","Lea"),
("Mario Perez","Marito"),
("Marcelo", "bocajunior"),
("Gustavo","bocajunior");

INSERT INTO usuarios 
(nombre, clave) VALUES
("Marcelo", "bocajunior");
-- 5.- 
SELECT nombre, clave FROM usuarios;
-- 6.- 
SELECT nombre, clave FROM usuarios WHERE nombre= "Leonardo" ;
-- 7.-
SELECT nombre, clave FROM usuarios WHERE clave= "bocajunior";

-- 1.-
DROP TABLE IF EXISTS usuarios;

-- 2.-
CREATE TABLE usuarios(
  nombre VARCHAR(30),
  clave VARCHAR(10),
  PRIMARY KEY (nombre)
);

-- 3.-

INSERT INTO usuarios 
(nombre, clave) VALUES
("Leonardo","Lea"),
("Mario Perez","Marito"),
("Marcelo", "bocajunior"),
("Gustavo","bocajunior");

-- 4.-

INSERT INTO usuarios 
(nombre, clave) VALUES
("Leonardo","Leo"),
("Mario Perez","Mar1"),
("Marcelo", "Mar2"),
("Gustavo","Gus");

-- 5.- 
INSERT INTO usuarios
(nombre, clave) VALUES
("Gustavo","Gus");

-- 6.-
DROP TABLE IF EXISTS libros;
-- 7.- unsigned permite asignas el tipo de dato
CREATE TABLE libros(
  codigo INT UNSIGNED AUTO_INCREMENT,
  titulo VARCHAR(40) NOT NULL,
  autor VARCHAR(30),
  editorial VARCHAR(15),
  precio DECIMAL (5,2) UNSIGNED,
  cantidad SMALLINT UNSIGNED,
  PRIMARY KEY (codigo) 
);
-- 8.-

INSERT INTO libros 
(titulo, autor, editorial, precio, cantidad) VALUES
("El aleph", "Borges", "Planeta", 15, 100),
("Martin Fierro", "Jose Hernandez", "Emece", 22.20, 200),
("Antologia Poetica", "Borges", "Planeta", 40, 150),
("Aprende PHP", "Mario Molina", "Emece", 18.20, 200),
("Cervantes y el Quijote", "Borges", "Paidos", 36.40, 100),
("Manual de PHP", "J.C Paez", "Paidos", 30.80, 100),
("Harry Potter y la piedra filosofal", "J.K.Rowling", "Paidos", 45.00, 500),
("Harry Potter y la camara secreta", "J.K.Rowling", "Paidos", 46.00, 300),
("Alicia en el pais de las maravillas","Lewis   Carroll","Paidos",null, 50)
;

-- -- 10.-
SELECT titulo, precio, cantidad, precio * cantidad FROM libros;

-- 11.-
SELECT titulo, precio, precio * 0.1, precio-(precio*0.1) FROM libros;

-- 12.- 
SELECT COUNT(*) FROM libros;

-- 13.-
SELECT COUNT(*) FROM libros WHERE editorial="Planeta";

-- 14.-
SELECT COUNT(*) FROM libros WHERE autor LIKE "%Bor%";

-- 15.-
SELECT COUNT(precio) FROM libros;

-- 16.-
SELECT SUM(cantidad) FROM libros;

-- 17.-
SELECT MAX(precio) FROM libros;

-- 18.-
SELECT MIN(precio) FROM libros WHERE autor LIKE "%Rowling%";

-- 19.-
SELECT AVG(precio) FROM libros; 

-- 20.-
SELECT AVG(precio) FROM libros WHERE titulo LIKE "%PHP%"; 
