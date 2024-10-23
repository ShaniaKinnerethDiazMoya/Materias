# Operaciones CRUD en mySQL

Las operaciones *CRUD* son un conjunto de 4 operaciones fundamentales en el manejo de bases de datos y aplicaciones web. CRUD es un acronimo que representa las siguientes operaciones:
- **C**REATE (Crear)
- **R**EAD (Leer)
- **U**PDATE (Actualizar)
- **D**ELETE (Eliminar)
 
**Primero creamos una tabla:** 

``` sql
CREATE TABLE Usuarios(
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL CHECK(email LIKE  "%_@_%._%"),
    password VARCHAR(15) NOT NULL CHECK(LENGTH(password) >= 8)
);
```
## Create 

La operacion *crear* es la responsable de insertar nuevos datos en la base de datos en lenguaje SQL esto se realiza con `INSERT INTO` y en el caso de mysql `INSERT` tambien funciona. El proposito de la operación es añadir el nuevo registro a una tabla 

```sql
--Ejemplo de una insercion valida usando todos los campos 
INSERT INTO usuarios VALUES (1,"ejemplo@mail.com","12345678")
--Ejemplo de una insercion valida usando default
INSERT INTO usuarios VALUES (DEFAULT,"ejemplo2@gmail.com","abcdefgh")
--Ejemplo de una insercion sin incluir el id_usuario
INSERT INTO usuarios(email,password)VALUES("email3@hotmail.com","12344321")
```
## Ejercicios 
Identifica los tipos de errores que pueden salir en esta tabla (4)
Inserta 4 registros nuevos en un solo INSERT

````sql
--Forzar una id que se puede duplicar 
INSERT INTO usuarios (id_usuario, email, password) 
VALUES (1, 'duplicado@mail.com', '11111111');
--Tener un campo nulo
INSERT INTO usuarios (email, password) 
VALUES (NULL, 'sinemail');
--longitud de datos 
INSERT INTO usuarios (email, password) 
VALUES ('unemailmuylargounemailmuylargounemailmuylargounemailmuylargo@mail.com', '123456');
--insertar numero en campo de texto
INSERT INTO usuarios (email, password) 
VALUES (123456, '12345678');


--insertar 4 registros
 INSERT INTO usuarios (email, password) 
VALUES 
('usuario4@mail.com', 'password4'),
('usuario5@mail.com', 'password5'),
('usuario6@mail.com', 'password6'),
('usuario7@mail.com', 'password7');

````

## Read

La operacidon *leer* es utilizada para consultar o recuperar datos de la base de datos. Esto no modifica los datos, simplemente los extrae. En mysql esta operacion se realiza a la sentencia select. 

````sql
--Ejemplo de una consulta para todos los datos de una tabla 
SELECT * FROM usuarios;
--Ejemplo de consulta para unregistro en especifico a traves del id
SELECT * FROM usuarios WHERE id_usuario=1;
--Ejemplo de consulta para un registro con email en especifico
SELECT * FROM usuariOS WHERE email="ejemplo@mail.com";
--Ejemplo de consulta con solo las cambios email y password
SELECT email,password FROM usuarios;
--Ejemplo de consulta con un condicional logico
SELECT * FROM usuarios WHERE LENGTH(password)>=9;
````

## Ejercicios 

Realiza una consulta que muestre solo el email pero que coincida con una contraseña de mas de 8 caracteres que realice una consulta a los id pares
```sql
--Consulta que muestra solo el email de los usuarios con contraseña de más de 8 caracteres y que tengan un id par
SELECT email 
FROM usuarios 
WHERE LENGTH(password) > 8 AND id_usuario % 2 = 0;
```
## Update 

La operacion *actualizar* se utiliza para modificar registros existentes en la base de datos. Esto se hace con la sentencia `UPDATE`

```sql
--Ejemplo para actualizar la contraseña por su id
UPDATE usuario SET password ="a1b2c3d4" WHERE id_usuario=1;
--Ejemplo para actualizar el email y password de un usuario en especifico
UPDATE usuario SET password ="a1b2c3d4",
email = "shaniadiaz@gmail.com" WHERE id_usuario = 1;
```
## Ejercicios
Intenta actualizar registros con valores que violen las restricciones, minimo 3
```sql
-- Violación del formato del email
UPDATE usuarios SET email = "correoinvalido" WHERE id_usuario = 1;
-- Violación de la longitud de la contraseña
UPDATE usuarios SET password = "123" WHERE id_usuario = 2;
-- Violación de la unicidad del email
UPDATE usuarios SET email = "usuarioexistente@mail.com" WHERE id_usuario = 3;

```

## Delete
La accion *eliminar* se usa para borrar registros en la base de datos, esto se realiza con la sentencia `DELETE`. **Debemos ser muy cuidadosos con esta operacion ya que una vez eliminados los datos, no puedn ser recuperados**.

```sql
--Eliminar el usuario por el id
DELETE FROM usuarios WHERE id_usuario=4;
--Eliminr los usuarios con el email especifico
DELETE FROM usuarios WHERE email= "shaniadiaz@gmail.com";

```
## Ejercicios
Eliminar usuarios cuyo email contenga 1 o mas 5s
Eliminar usuarios que tengan una contraseña que contenga letras mayusculas usando expresiones regulares 
Como es con `LIKE` aqui sera `REGEXP`
Eliminar usuarios con contraseñas que contengan solo numeros `REGEX`
Eliminar usuarios con correos que no tengan el dominio gmail

```sql
-- Eliminar usuarios cuyo email contenga uno o más cincos (5)
DELETE FROM usuarios WHERE email REGEXP '5';
-- Eliminar usuarios con contraseñas que contengan letras mayúsculas
DELETE FROM usuarios WHERE password REGEXP '[A-Z]';
-- Eliminar usuarios con contraseñas que contengan solo números
DELETE FROM usuarios WHERE password REGEXP '^[0-9]+$';
-- Eliminar usuarios con correos que no tengan el dominio "gmail"
DELETE FROM usuarios WHERE email NOT LIKE '%@gmail.com';
```

REGEXP '5': Busca correos que contengan el número 5 en cualquier posición.
REGEXP '[A-Z]': Busca contraseñas que contengan al menos una letra mayúscula.
REGEXP '^[0-9]+$': Verifica que la contraseña esté compuesta solo por números del principio al final.
NOT LIKE '%@gmail.com': Encuentra correos que no terminen con el dominio @gmail.com.

