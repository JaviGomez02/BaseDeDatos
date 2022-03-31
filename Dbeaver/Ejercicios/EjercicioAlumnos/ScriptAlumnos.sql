CREATE TABLE PROFESOR
(DNI VARCHAR2(9),
nombre VARCHAR2(20),
direccion VARCHAR2(40),
titulacion VARCHAR2(20),
sueldo NUMBER(5,2) NOT NULL,
CONSTRAINT pk_profesor PRIMARY KEY (DNI)
);

CREATE TABLE CURSO
(codigo NUMBER(10) NOT NULL,
nombre VARCHAR2(20),
fecha_inicio DATE,
fecha_final DATE,
num_max_alumnos NUMBER(3),
num_horas NUMBER(3) NOT NULL,
DNI_profesor VARCHAR2(9),
CONSTRAINT pk_curso PRIMARY KEY (codigo),
CONSTRAINT fk_curso FOREIGN KEY (DNI_profesor) REFERENCES PROFESOR(DNI)
);

CREATE TABLE ALUMNOS
(DNI VARCHAR2(9),
sexo VARCHAR2(1),
nombre VARCHAR2(20),
apellidos VARCHAR2(30),
fecha_nac DATE,
direccion VARCHAR2(40),
codigo_curso NUMBER(10) NOT NULL,
CONSTRAINT pk_alumnos PRIMARY KEY (DNI),
CONSTRAINT fk_alumnos FOREIGN KEY (codigo_curso) REFERENCES CURSO(codigo)
);

ALTER TABLE CURSO ADD CONSTRAINT condicion1_cursos CHECK ((fecha_inicio)<(fecha_final));

ALTER TABLE ALUMNOS ADD CONSTRAINT condicion1_alumnos CHECK (sexo IN ('H','F'))