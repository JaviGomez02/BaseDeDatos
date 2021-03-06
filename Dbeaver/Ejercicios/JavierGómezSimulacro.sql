--Creación de usuario

/*alter session set "_oracle_script"=true;  
create user JAVIGOMEZ identified by JAVIGOMEZ;
GRANT CONNECT, RESOURCE, DBA TO JAVIGOMEZ;*/

--Apartado 1

CREATE TABLE ALUMNO
(NUMMATRICULA NUMBER(10),
NOMBRE VARCHAR2(30),
FECHANACIMIENTO DATE,
TELEFONO VARCHAR2(9),
CONSTRAINT PK_ALUMNO PRIMARY KEY (NUMMATRICULA)
);

CREATE TABLE PROFESOR
(IDPROFESOR NUMBER(10),
NIF_P VARCHAR2(9),
NOMBRE VARCHAR2(30),
ESPECIALIDAD VARCHAR2(30),
TELEFONO VARCHAR2(9),
CONSTRAINT PK_PROFESOR PRIMARY KEY (IDPROFESOR)
);

CREATE TABLE ASIGNATURA
(CODASIGNATURA VARCHAR2(10),
NOMBRE VARCHAR2(9),
IDPROFESOR NUMBER(10),
CONSTRAINT PK_ASIGNATURA PRIMARY KEY (CODASIGNATURA),
CONSTRAINT FK_ASIGNATURA FOREIGN KEY (IDPROFESOR) REFERENCES PROFESOR(IDPROFESOR)
);

ALTER TABLE ASIGNATURA MODIFY NOMBRE VARCHAR2(30);

CREATE TABLE RECIBE
(NUMMATRICULA NUMBER(10),
CODASIGNATURA VARCHAR2(10),
CURSOESCOLAR VARCHAR2(20),
CONSTRAINT PK_RECIBE PRIMARY KEY (NUMMATRICULA,CODASIGNATURA,CURSOESCOLAR),
CONSTRAINT FK1_RECIBE FOREIGN KEY (CODASIGNATURA) REFERENCES ASIGNATURA(CODASIGNATURA),
CONSTRAINT FK2_RECIBE FOREIGN KEY (NUMMATRICULA) REFERENCES ALUMNO(NUMMATRICULA)
);

--Apartado 2

INSERT INTO PROFESOR VALUES ('31234','33443344D','Juan Miguel','Matemáticas','955802343');
INSERT INTO PROFESOR VALUES ('1243','12345678A','Antonio Jesus','Inglés','955362234');

INSERT INTO ASIGNATURA VALUES ('234','LENGUA','1243');
INSERT INTO ASIGNATURA VALUES ('12','MATEMATICAS','31234');
INSERT INTO ASIGNATURA VALUES ('1','INGLES','1243');
INSERT INTO ASIGNATURA VALUES ('2','TECNOLOGIA','31234');

INSERT INTO ALUMNO VALUES ('1','Manuel',TO_DATE('05/02/2001','DD/MM/YYYY'),'622455212');
INSERT INTO ALUMNO VALUES ('2','Jesus',TO_DATE('08/02/2002','DD/MM/YYYY'),'622455212');
INSERT INTO ALUMNO VALUES ('3','Julian',TO_DATE('05/10/2000','DD/MM/YYYY'),'622455212');
INSERT INTO ALUMNO VALUES ('4','Miguel',TO_DATE('25/02/1998','DD/MM/YYYY'),'622455212');
INSERT INTO ALUMNO VALUES ('5','Antonio',TO_DATE('12/07/2002','DD/MM/YYYY'),'622455212');
INSERT INTO ALUMNO VALUES ('6','Manolin',TO_DATE('09/06/2002','DD/MM/YYYY'),'622455212');
INSERT INTO ALUMNO VALUES ('7','Javi',TO_DATE('27/08/2002','DD/MM/YYYY'),'622455212');
INSERT INTO ALUMNO VALUES ('8','Alberto',TO_DATE('05/01/2002','DD/MM/YYYY'),'622455212');
INSERT INTO ALUMNO VALUES ('9','Florian',TO_DATE('12/02/2001','DD/MM/YYYY'),'622455212');
INSERT INTO ALUMNO VALUES ('10','Jose',TO_DATE('23/11/2002','DD/MM/YYYY'),'622455212');

INSERT INTO RECIBE VALUES ('1','1','1 BACHILLERATO');
INSERT INTO RECIBE VALUES ('1','234','1 BACHILLERATO');
INSERT INTO RECIBE VALUES ('2','234','3 ESO');
INSERT INTO RECIBE VALUES ('2','2','3 ESO');
INSERT INTO RECIBE VALUES ('3','1','1 ESO');
INSERT INTO RECIBE VALUES ('3','2','1 ESO');
INSERT INTO RECIBE VALUES ('4','2','2 BACHILLERATO');
INSERT INTO RECIBE VALUES ('4','234','2 BACHILLERATO');
INSERT INTO RECIBE VALUES ('5','234','2 BACHILLERATO');
INSERT INTO RECIBE VALUES ('5','1','2 BACHILLERATO');
INSERT INTO RECIBE VALUES ('6','2','2 BACHILLERATO');
INSERT INTO RECIBE VALUES ('6','12','2 BACHILLERATO');
INSERT INTO RECIBE VALUES ('7','234','2 BACHILLERATO');
INSERT INTO RECIBE VALUES ('7','12','2 BACHILLERATO');
INSERT INTO RECIBE VALUES ('8','234','2 BACHILLERATO');
INSERT INTO RECIBE VALUES ('8','1','2 BACHILLERATO');
INSERT INTO RECIBE VALUES ('9','2','2 BACHILLERATO');
INSERT INTO RECIBE VALUES ('9','1','2 BACHILLERATO');
INSERT INTO RECIBE VALUES ('10','12','2 BACHILLERATO');
INSERT INTO RECIBE VALUES ('10','234','2 BACHILLERATO');



--Apartado 3
INSERT INTO ALUMNO VALUES ('11','Alvaro',TO_DATE('05/06/2001','DD/MM/YYYY'),'622665064');
INSERT INTO ALUMNO VALUES ('11','Victor',TO_DATE('13/02/2003','DD/MM/YYYY'),'622455212');
--No nos deja introducir dos alumnos con el mismo número de matricula, ya que la primary key es única.
--Para que nos deje debemos introducirle al segundo alumno una matricula diferente
INSERT INTO ALUMNO VALUES ('12','Victor',TO_DATE('13/02/2003','DD/MM/YYYY'),'622455212');

--Apartado 4
INSERT INTO ALUMNO (NUMMATRICULA,NOMBRE,FECHANACIMIENTO) VALUES ('13','JoseManuel',TO_DATE('30/06/2000','DD/MM/YYYY'));
INSERT INTO ALUMNO (NUMMATRICULA,NOMBRE,FECHANACIMIENTO) VALUES ('14','Carlos',TO_DATE('12/08/2003','DD/MM/YYYY'));
INSERT INTO ALUMNO (NUMMATRICULA,NOMBRE,FECHANACIMIENTO) VALUES ('15','Enrique',TO_DATE('10/11/2003','DD/MM/YYYY'));

--Apartado 5
UPDATE ALUMNO SET TELEFONO='622556323' WHERE NUMMATRICULA='13';
UPDATE ALUMNO SET TELEFONO='642234456' WHERE NUMMATRICULA='14';
UPDATE ALUMNO SET TELEFONO='676663314' WHERE NUMMATRICULA='15';

--Apartado 6
UPDATE ALUMNO SET FECHANACIMIENTO=TO_DATE('22/07/1981','DD/MM/YYYY') WHERE (EXTRACT(YEAR FROM FECHANACIMIENTO)>2000);
SELECT * FROM ALUMNO;

--Apartado 7
UPDATE PROFESOR SET ESPECIALIDAD='Informática' WHERE (TELEFONO LIKE('%') AND NIF_P NOT LIKE('9%'));
SELECT * FROM PROFESOR;

--Apartado 8
DELETE FROM RECIBE WHERE CODASIGNATURA='234';

--Apartado 9
DELETE FROM ASIGNATURA WHERE CODASIGNATURA='234';

--Apartado 10
DELETE FROM ASIGNATURA;
--No nos deja borrar los datos porque están ligados a otras trablas
--Tenemos que borrar la informacion de RECIBE
DELETE FROM RECIBE;
DELETE FROM ASIGNATURA;


--Apartado 11
DELETE FROM PROFESOR;

--Apartado 12
UPDATE ALUMNO SET NOMBRE=UPPER(NOMBRE);
SELECT * FROM ALUMNO;

--Apartado 13
CREATE TABLE ALUMNO_BACKUP
(NUMMATRICULA NUMBER(10),
NOMBRE VARCHAR2(30),
FECHANACIMIENTO DATE,
TELEFONO VARCHAR2(9),
CONSTRAINT PK_ALUMNO_BACKUP PRIMARY KEY (NUMMATRICULA)
);

INSERT INTO ALUMNO_BACKUP SELECT * FROM ALUMNO;

SELECT * FROM ALUMNO_BACKUP;


DROP TABLE ALUMNO CASCADE CONSTRAINT;
DROP TABLE PROFESOR CASCADE CONSTRAINT;
DROP TABLE ASIGNATURA CASCADE CONSTRAINT;

DROP TABLE RECIBE CASCADE CONSTRAINT;

