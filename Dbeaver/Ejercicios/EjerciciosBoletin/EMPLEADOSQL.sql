CREATE TABLE DEPARTAMENTO
(codigo INT(10) AUTO_INCREMENT,
nombre VARCHAR(100),
presupuesto DOUBLE(10,2),
gastos DOUBLE(10,2),
CONSTRAINT pk_departamento PRIMARY KEY (codigo)
);

CREATE TABLE EMPLEADO
(codigo INT(10) AUTO_INCREMENT,
NIF VARCHAR(9),
nombre VARCHAR(100),
apellido1 VARCHAR(100),
apellido2 VARCHAR(100),
codigo_departamento INT(10),
CONSTRAINT pk_empleado PRIMARY KEY (codigo),
CONSTRAINT fk_empleado FOREIGN KEY (codigo_departamento) REFERENCES DEPARTAMENTO(codigo)
);


INSERT INTO DEPARTAMENTO VALUES (1, 'Desarrollo', 120000, 6000);
INSERT INTO DEPARTAMENTO VALUES (2, 'Sistemas', 150000, 21000);
INSERT INTO DEPARTAMENTO VALUES (3, 'Recursos Humanos', 280000, 25000);
INSERT INTO DEPARTAMENTO VALUES (4, 'Contabilidad', 110000, 3000);
INSERT INTO DEPARTAMENTO VALUES (5, 'I+D', 375000, 380000);
INSERT INTO DEPARTAMENTO VALUES (6, 'Proyectos', 0, 0);
INSERT INTO DEPARTAMENTO VALUES (7, 'Publicidad', 0, 1000);

INSERT INTO EMPLEADO VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO EMPLEADO VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO EMPLEADO VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO EMPLEADO VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO EMPLEADO VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO EMPLEADO VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO EMPLEADO VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO EMPLEADO VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO EMPLEADO VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO EMPLEADO VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO EMPLEADO VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO EMPLEADO VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO EMPLEADO VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);

/*1. Inserta un nuevo departamento indicando su código, nombre y presupuesto.*/
INSERT INTO DEPARTAMENTO (codigo,nombre,presupuesto) VALUES (8, 'Marketing', 3443334);

/*2. Inserta un nuevo departamento indicando su nombre y presupuesto.*/
INSERT INTO DEPARTAMENTO (nombre,presupuesto) VALUES ('Informatica', 322221);

/*3. Inserta un nuevo departamento indicando su código, nombre, presupuesto y gastos*/
INSERT INTO DEPARTAMENTO (codigo,nombre,presupuesto,gastos) VALUES (10, 'Electronica', 23000,4200);

/*4. Inserta un nuevo empleado asociado a uno de los nuevos
departamentos. La sentencia de inserción debe
incluir: código, nif, nombre, apellido1, apellido2 y codigo_departamento.*/
INSERT INTO EMPLEADO (codigo,NIF,nombre,apellido1,apellido2,codigo_departamento) VALUES(14, '53345534G', 'Antonio', 'Recio', 'Matamoros', 8);

/*5. Inserta un nuevo empleado asociado a uno de los nuevos
departamentos. La sentencia de inserción debe
incluir: nif, nombre, apellido1, apellido2 y codigo_departamento*/
INSERT INTO EMPLEADO (NIF,nombre,apellido1,apellido2,codigo_departamento) VALUES('53684545E', 'Alejandro', 'Martinez', 'Zamora', 10);

/*6. Crea una nueva tabla con el nombre departamento_backup que tenga las
--mismas columnas que la tabla departamento. Una vez creada copia todos
--las filas de tabla departamento en departamento_backup.*/

CREATE TABLE DEPARTAMENTO_BACKUP
(codigo INT(10) AUTO_INCREMENT,
nombre VARCHAR(100),
presupuesto DOUBLE(10,2),
gastos DOUBLE(10,2),
CONSTRAINT pk_departamento_backup PRIMARY KEY (codigo)
);

INSERT INTO DEPARTAMENTO_BACKUP(codigo,nombre,presupuesto,gastos)
SELECT codigo,nombre,presupuesto,gastos FROM DEPARTAMENTO;

/*7. Elimina el departamento Proyectos. ¿Es posible eliminarlo? Si no fuese
--posible, ¿qué cambios debería realizar para que fuese posible borrarlo?*/
DELETE FROM DEPARTAMENTO WHERE upper(nombre)='PROYECTOS';

/*8. Elimina el departamento Desarrollo. ¿Es posible eliminarlo? Si no fuese
--posible, ¿qué cambios debería realizar para que fuese posible borrarlo?*/

ALTER TABLE EMPLEADO DROP CONSTRAINT fk_empleado;
ALTER TABLE EMPLEADO ADD CONSTRAINT fk_empleado FOREIGN KEY (codigo_departamento) REFERENCES DEPARTAMENTO(codigo) ON DELETE CASCADE;

DELETE FROM DEPARTAMENTO WHERE upper(nombre)='DESARROLLO';

SELECT * FROM DEPARTAMENTO;

/*9. Actualiza el código del departamento Recursos Humanos y asígnale el valor
--30. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería
--realizar para que fuese actualizarlo?*/
UPDATE DEPARTAMENTO SET codigo=30 WHERE nombre='Recursos Humanos';

/*10.Actualiza el código del departamento Publicidad y asígnale el valor 40.
--¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería
--realizar para que fuese actualizarlo?*/
UPDATE DEPARTAMENTO SET codigo=40 WHERE upper(nombre)='PUBLICIDAD';

/*11.Actualiza el presupuesto de los departamentos sumándole 50000 € al
--valor del presupuesto actual, solamente a aquellos departamentos que
--tienen un presupuesto menor que 20000 €*/
SELECT * FROM DEPARTAMENTO

UPDATE DEPARTAMENTO SET presupuesto=presupuesto+50000 WHERE presupuesto<20000;

/*12.Realiza una transacción que elimine todas los empleados que no tienen
--un departamento asociado.*/
SELECT * FROM EMPLEADO

DELETE FROM EMPLEADO WHERE codigo_departamento IS NULL;


DROP TABLE DEPARTAMENTO CASCADE CONSTRAINT;
DROP TABLE EMPLEADO CASCADE CONSTRAINT;


