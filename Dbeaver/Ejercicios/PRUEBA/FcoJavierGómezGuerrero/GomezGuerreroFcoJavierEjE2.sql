alter session set "_oracle_script"=true;  
create user GOMEZFCOJAVIEREje2 identified by GOMEZFCOJAVIEREje2;
GRANT CONNECT, RESOURCE, DBA TO GOMEZFCOJAVIEREje2;

CREATE TABLE PERSONA
(id NUMBER(10),
nif VARCHAR2(9),
nombre VARCHAR2(25),
apellido1 VARCHAR2(50),
apellido2 VARCHAR2(50),
ciudad VARCHAR2(25),
direccion VARCHAR2(50),
telefono VARCHAR2(9),
fecha_nacimiento DATE,
sexo VARCHAR2(1),
tipo VARCHAR2(10),
CONSTRAINT pk_persona PRIMARY KEY (id),
CONSTRAINT condicion_sexo CHECK (sexo IN ('H','M')),
CONSTRAINT condicion_tipo CHECK (tipo IN ('NIÑO','ADULTO','ANCIANO'))
);

CREATE TABLE DEPARTAMENTO
(id NUMBER(10),
nombre VARCHAR2(50),
CONSTRAINT pk_departamento PRIMARY KEY(id)
);

CREATE TABLE PROFESOR
(id_profesor NUMBER(10),
id_departamento NUMBER(10),
CONSTRAINT pk_profesor PRIMARY KEY(id_profesor),
CONSTRAINT fk_profesor FOREIGN KEY(id_profesor) REFERENCES PERSONA(id),
CONSTRAINT fk2_profesor FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO(id)
);

CREATE TABLE GRADO
(id NUMBER(10),
nombre VARCHAR2(100),
CONSTRAINT pk_grado PRIMARY KEY (id)
);

CREATE TABLE ASIGNATURA
(id NUMBER(10),
nombre VARCHAR2(100),
creditos NUMBER(5,2),
tipo VARCHAR2(20),
curso NUMBER(3),
cuatrimestre NUMBER(3),
id_profesor NUMBER (10),
id_grado NUMBER(10),
CONSTRAINT pk_asignatura PRIMARY KEY (id),
CONSTRAINT fk1_asignatura FOREIGN KEY (id_profesor) REFERENCES PROFESOR(id_profesor),
CONSTRAINT fk2_asignatura FOREIGN KEY (id_grado) REFERENCES GRADO(id),
CONSTRAINT condicion_tipo_asignatura CHECK (tipo IN ('TELEMATICA'))
);

CREATE TABLE CURSO_ESCOLAR
(id NUMBER(10),
anyo_inicial NUMBER(4),
anyo_fin NUMBER(4),
CONSTRAINT pk_curso_escolar PRIMARY KEY (id)
);

CREATE TABLE ALUMNO_SE_MATRICULA_ASIGNATURA
(id_alumno NUMBER(10),
id_asignatura NUMBER(10),
id_curso_escolar NUMBER(10),
CONSTRAINT pk_alumnomatricula PRIMARY KEY (id_alumno,id_asignatura,id_curso_escolar),
CONSTRAINT fk1_alumnomatricula FOREIGN KEY (id_alumno) REFERENCES PERSONA(id),
CONSTRAINT fk2_alumnomatricula FOREIGN KEY (id_asignatura) REFERENCES ASIGNATURA(id),
CONSTRAINT fk3_alumnomatricula FOREIGN KEY (id_curso_escolar) REFERENCES CURSO_ESCOLAR(id)
);

-- En la tabla personas el campo nombre siempre debe de introducirse en mayúsculas.
ALTER TABLE PERSONA ADD CONSTRAINT condicion_nombre CHECK (nombre=UPPER(nombre));

--Añade el campo edad a la tabla persona como un campo numérico de 3
ALTER TABLE PERSONA ADD edad NUMBER(3);

--Añade una restricción para que el nuevo campo edad deba estar comprendido entre 7 y 25 años.
ALTER TABLE PERSONA ADD CONSTRAINT condicion_edad CHECK ((edad>=7) AND (edad<=25));

--En el curso escolar, el anyo_inicio no puede ser mayor que el anyo_fin
ALTER TABLE CURSO_ESCOLAR ADD CONSTRAINT condicion_anyos CHECK (anyo_inicial<anyo_fin);

-- El campo cuatrimestre solo puede tomar valores entre 1 y 4.
ALTER TABLE ASIGNATURA ADD CONSTRAINT condicion_cuatrimestre CHECK (cuatrimestre IN (1,2,3,4));

--En la tabla asignatura los valores que contendrá el campo tipo deberán empezar siempre por la letra T.
ALTER TABLE ASIGNATURA ADD CONSTRAINT condicion2_tipo CHECK (tipo LIKE ('T%'));

--Crea una restricción para la tabla persona donde al año de la fecha_nacimiento debe ser mayor que 1981.
ALTER TABLE PERSONA ADD CONSTRAINT condicion_fecha CHECK (EXTRACT (YEAR FROM fecha_nacimiento)>1981);

--Elimina la colunna creditos de la tabla asignatura.
ALTER TABLE ASIGNATURA DROP COLUMN creditos;

--Borra todas las tablas.
/*DROP TABLE PERSONA CASCADE CONSTRAINT;
DROP TABLE PROFESOR CASCADE CONSTRAINT;
DROP TABLE DEPARTAMENTO CASCADE CONSTRAINT;
DROP TABLE ASIGNATURA CASCADE CONSTRAINT;
DROP TABLE GRADO CASCADE CONSTRAINT;
DROP TABLE ALUMNO_SE_MATRICULA_ASIGNATURA CASCADE CONSTRAINT;
DROP TABLE CURSO_ESCOLAR CASCADE CONSTRAINT;*/














