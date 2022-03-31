SELECT * FROM ALUMNO;
SELECT * FROM ALUMNO_ASIGNATURA;
SELECT * FROM ASIGNATURA;
SELECT * FROM PERSONA;
SELECT * FROM PROFESOR;
SELECT * FROM TITULACION;


--APARTADO 1

--Insertamos un profesor inventado para la asignatura
INSERT INTO PERSONA (DNI,NOMBRE,APELLIDO,CIUDAD) VALUES ('11111111A','Alvaro','Gomez','Brenes');
INSERT INTO PROFESOR VALUES ('1','11111111A');

--Insertamos la asignatura contabilidad y le asignamos el nuevo profesor
INSERT INTO ASIGNATURA VALUES ('1A','Contabilidad',4,1,30,'1',NULL,NULL);

--Nos insertamos a nosotros como nuevo alumno
INSERT INTO PERSONA VALUES ('29596389V','Javier','Gómez','Lora','FedericoGarciaLorca',5,'622663070',TO_DATE('05/02/2002','DD/MM/YYYY'),1);
INSERT INTO ALUMNO VALUES ('1A','29596389V');

--Nos asignamos en la asignatura contabilidad
INSERT INTO ALUMNO_ASIGNATURA VALUES ('1A','1A',3);

--APARTADO 2

--Creamos la nueva profesora
INSERT INTO PERSONA VALUES ('77222122K','MARTA','LÓPEZ','SEVILLA','CALLE TARFIA',9,'615891432',TO_DATE('22/07/1981','DD/MM/YYYY'),0);
INSERT INTO PROFESOR VALUES ('1B','77222122K');

--Modificamos la asignatura Contabilidad
UPDATE ASIGNATURA SET IDPROFESOR='1B' WHERE NOMBRE='Contabilidad';

--Borramos el antiguo profesor
DELETE FROM PERSONA WHERE DNI='1111111A';
DELETE FROM PROFESOR WHERE IDPROFESOR='1';

--APARTADO 3

--Creamos la nueva tabla
CREATE TABLE ALUMNOS_MUYREPETIDORES
(IDASIGNATURA VARCHAR2(20),
IDALUMNO VARCHAR2(9),
NOMBRE VARCHAR2(30),
APELLIDO VARCHAR2(50),
TELEFONO VARCHAR2(9),
CONSTRAINT PK_ALUMNOSREPETIDORES PRIMARY KEY (IDALUMNO),
CONSTRAINT FK_ALUMNOSREPETIDORES FOREIGN KEY (IDASIGNATURA) REFERENCES ASIGNATURA(IDASIGNATURA)
);

--Insertamos los alumnos
SELECT * FROM ALUMNO_ASIGNATURA WHERE NUMEROMATRICULA>=3;
INSERT INTO ALUMNOS_MUYREPETIDORES(IDALUMNO,IDASIGNATURA) SELECT IDALUMNO,IDASIGNATURA FROM ALUMNO_ASIGNATURA WHERE NUMEROMATRICULA>=3;

--Comprobamos los datos
SELECT * FROM ALUMNOS_MUYREPETIDORES;

--APARTADO 4

--Añadimos numeros de telefono aleatorios, ya que los alumnos no tienen numero de teléfono
UPDATE ALUMNOS_MUYREPETIDORES SET TELEFONO='954322420' WHERE IDALUMNO='1A';
UPDATE ALUMNOS_MUYREPETIDORES SET TELEFONO='956344123' WHERE IDALUMNO='A030303';
UPDATE ALUMNOS_MUYREPETIDORES SET TELEFONO='955432087' WHERE IDALUMNO='A131313';

--Añadimos la nueva columna
ALTER TABLE ALUMNOS_MUYREPETIDORES ADD OBSERVACIONES VARCHAR2(50);

--Modificamos los alumnos
SELECT IDALUMNO FROM PERSONA p, ALUMNO a WHERE CIUDAD LIKE 'Sevilla' AND p.DNI=a.DNI;

UPDATE ALUMNOS_MUYREPETIDORES SET OBSERVACIONES='Se encuentra en seguimiento' WHERE IDALUMNO IN(SELECT IDALUMNO FROM PERSONA p, ALUMNO a WHERE CIUDAD LIKE 'Sevilla' AND p.DNI=a.DNI) AND TELEFONO LIKE '%20%';

--APARTADO 5

--Buscamos los alumnos y borramos los datos
SELECT IDALUMNO FROM PERSONA p, ALUMNO a WHERE TO_DATE(FECHA_NACIMIENTO,'DD/MM/YYYY') LIKE '%/11/1971' AND p.DNI=a.DNI;

DELETE FROM ALUMNOS_MUYREPETIDORES WHERE IDALUMNO IN (SELECT IDALUMNO FROM PERSONA p, ALUMNO a WHERE TO_DATE(FECHA_NACIMIENTO,'DD/MM/YYYY') LIKE '%/11/1971' AND p.DNI=a.DNI);

--APARTADO 6*

--Creamos la nueva tabla
CREATE TABLE RESUMEN_TITULACIONES
(NOMBRE_TITULACION VARCHAR2(30),
NUMEROASIGNATURAS NUMBER(10),
CONSTRAINT PK_RESUMEN_TITULACIONES PRIMARY KEY (NOMBRE_TITULACION)
);

--Añadimos los datos
INSERT INTO RESUMEN_TITULACIONES(NOMBRE_TITULACION,NUMEROASIGNATURAS) SELECT NOMBRE,IDTITULACION FROM TITULACION;

--Comprobamos los datos
SELECT * FROM RESUMEN_TITULACIONES;

--APARTADO 7

--7.1: Mientras el otro programador tenga acceso a la base de datos si podrá consultar los datos introducidos por otro programador

--7.2: 

--7.3: Para volver a la situación inicial de la tabla sin datos, debes borrar los datos introducidos con la instrucción DELETE,
--o bien se pueden modificar los datos con la instrucción UPDATE para que sean correctos

--7.4: Para insertar los datos debemos utilizar la instruccion INSERT INTO

--7.5: Tendríamos que haber creado una tabla como backup de la tabla CLIENTE, para poder recuperar los datos en caso de que los perdamos.
--Lo que haría yo sería crear un backup de cada tabla antes de realizar operaciones con cierto nivel de riesgo como DELETE o UPDATE.

--7.6: El SAVEPOINT nos sirve para crear puntos de guardado de las tablas, a las que podremos acceder en caso de que perdamos los datos.






