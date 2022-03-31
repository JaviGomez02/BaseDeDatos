CREATE TABLE FABRICANTE
(codigo NUMBER(10),
nombre VARCHAR2(100),
CONSTRAINT pk_fabricante PRIMARY KEY (codigo)
);

CREATE TABLE PRODUCTO
(codigo NUMBER(10),
nombre VARCHAR2(100),
precio NUMBER(6,2),
codigo_fabricante NUMBER(10),
CONSTRAINT pk_producto PRIMARY KEY (codigo),
CONSTRAINT fk_producto FOREIGN KEY (codigo_fabricante) REFERENCES FABRICANTE(codigo)
);

INSERT INTO FABRICANTE (codigo,nombre) VALUES (1,'Asus');
INSERT INTO FABRICANTE (codigo,nombre) VALUES (2,'Lenovo');
INSERT INTO FABRICANTE (codigo,nombre) VALUES (3,'Hewlett-Packard');
INSERT INTO FABRICANTE (codigo,nombre) VALUES (4,'Samsung');
INSERT INTO FABRICANTE (codigo,nombre) VALUES (5,'Seagate');
INSERT INTO FABRICANTE (codigo,nombre) VALUES (6,'Crucial');
INSERT INTO FABRICANTE (codigo,nombre) VALUES (7,'Gigabyte');
INSERT INTO FABRICANTE (codigo,nombre) VALUES (8,'Huawei');
INSERT INTO FABRICANTE (codigo,nombre) VALUES (9,'Xiaomi');

INSERT INTO PRODUCTO (codigo,nombre,precio,codigo_fabricante) VALUES (1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO PRODUCTO (codigo,nombre,precio,codigo_fabricante) VALUES (2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO PRODUCTO (codigo,nombre,precio,codigo_fabricante) VALUES (3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO PRODUCTO (codigo,nombre,precio,codigo_fabricante) VALUES (4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO PRODUCTO (codigo,nombre,precio,codigo_fabricante) VALUES (5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO PRODUCTO (codigo,nombre,precio,codigo_fabricante) VALUES (6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO PRODUCTO (codigo,nombre,precio,codigo_fabricante) VALUES (7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO PRODUCTO (codigo,nombre,precio,codigo_fabricante) VALUES (8, 'Portátil Yoga 520', 559, 2);
INSERT INTO PRODUCTO (codigo,nombre,precio,codigo_fabricante) VALUES (9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO PRODUCTO (codigo,nombre,precio,codigo_fabricante) VALUES (10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO PRODUCTO (codigo,nombre,precio,codigo_fabricante) VALUES (11, 'Impresora HP Laserjet Pro M26nw', 180, 3);


--1. Inserta un nuevo fabricante indicando su código y su nombre
INSERT INTO FABRICANTE (codigo,nombre) VALUES (10,'Intel');

--2. Inserta un nuevo fabricante indicando solamente su nombre
--INSERT INTO FABRICANTE (codigo,nombre) VALUES (NULL,'AMD');

--Inserta un nuevo producto asociado a uno de los nuevos fabricantes. La sentencia de inserción debe incluir: código, nombre, precio y código_fabricante.
INSERT INTO PRODUCTO (codigo,nombre,precio,codigo_fabricante) VALUES (12, 'i3-3300k', 130, 10);

--4. Inserta un nuevo producto asociado a uno de los nuevos fabricantes. La sentencia de inserción debe incluir: nombre, precio y código_fabricante.
--INSERT INTO PRODUCTO (nombre,precio,codigo_fabricante) VALUES ('i5-6500', 130, 10);

--5. Elimina el fabricante Asus. ¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?
DELETE FROM FABRICANTE WHERE nombre='Asus';

--6. Elimina el fabricante Xiaomi. ¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?
DELETE FROM FABRICANTE WHERE nombre='Xiaomi';

--7. Actualiza el código del fabricante Lenovo y asígnale el valor 20. ¿Es
--posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar
--para que fuese actualizarlo?
UPDATE FABRICANTE SET codigo=20 WHERE nombre='Lenovo';

--8. Actualiza el código del fabricante Huawei y asígnale el valor 30. ¿Es
--posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar
--para que fuese actualizarlo?
UPDATE FABRICANTE SET codigo=30 WHERE nombre='Huawei';

--9. Actualiza el precio de todos los productos sumándole 5 € al precio actual
UPDATE PRODUCTO SET precio=precio+5;

--10. Elimina todas las impresoras que tienen un precio menor de 200 €.
SELECT * FROM PRODUCTO WHERE upper(nombre) LIKE upper('%Impresora%');
DELETE FROM PRODUCTO WHERE upper(nombre) LIKE upper('%Impresora%') AND precio<200;



--DROP TABLE FABRICANTE CASCADE CONSTRAINT;
--DROP TABLE PRODUCTO CASCADE CONSTRAINT;