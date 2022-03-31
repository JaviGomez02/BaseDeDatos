CREATE TABLE CABALLOS
(cod_caballo VARCHAR2(4),
nombre VARCHAR2(20) NOT NULL,
peso NUMBER(3),
fecha_nac DATE,
propietario VARCHAR2(25),
nacionalidad VARCHAR2(20),
CONSTRAINT pk_caballos PRIMARY KEY (cod_caballo),
CONSTRAINT condicion_peso CHECK (peso>=240 AND peso<=300),
CONSTRAINT condicion_fecha CHECK (EXTRACT (YEAR from fecha_nac) >2000),
CONSTRAINT condicion_nacionalidad CHECK (nacionalidad=upper(nacionalidad))
);

CREATE TABLE CLIENTES
(DNI VARCHAR2(10),
nombre VARCHAR2(20),
nacionalidad VARCHAR2(20),
CONSTRAINT pk_clientes PRIMARY KEY (DNI),
CONSTRAINT condicion_DNI CHECK (regexp_like(DNI,'[0-9]{8}[A-Z]{1}')),
CONSTRAINT condicion_nacionalidad2 CHECK (nacionalidad=upper(nacionalidad))
);

CREATE TABLE CARRERAS
(cod_carrera VARCHAR2(4),
fecha_hora DATE,
importe_premio NUMBER(6),
apuesta_limite NUMBER(5,2),
CONSTRAINT condicion_apuesta CHECK (apuesta_limite<20000),
CONSTRAINT condicion_fecha_carreras CHECK (TO_CHAR(fecha_hora,'hh24:mi') BETWEEN '09:00' AND '14:20'),
CONSTRAINT pk_carrera PRIMARY KEY (cod_carrera)
);

CREATE TABLE PARTICIPACIONES
(cod_caballo VARCHAR2(4),
cod_carrera VARCHAR2(4),
dorsal NUMBER(2) NOT NULL,
jockey VARCHAR2(10) NOT NULL,
posicion_final NUMBER(2),
CONSTRAINT condicion_posicion CHECK (posicion_final>0),
CONSTRAINT pk_participaciones PRIMARY KEY (cod_caballo,cod_carrera),
CONSTRAINT fk1_participaciones FOREIGN KEY (cod_caballo) REFERENCES CABALLOS(cod_caballo),
CONSTRAINT fk2_participaciones FOREIGN KEY (cod_carrera) REFERENCES CARRERAS(cod_carrera)
);

CREATE TABLE APUESTAS
(DNI_cliente VARCHAR2(10),
cod_caballo VARCHAR2(4),
cod_carrera VARCHAR2(4),
importe NUMBER(6) DEFAULT 300 NOT NULL,
tantoporuno NUMBER(4,2),
CONSTRAINT condicion_tantoporuno CHECK (tantoporuno>1),
CONSTRAINT pk_apuestas PRIMARY KEY (DNI_cliente,cod_caballo,cod_carrera),
CONSTRAINT fk1_apuestas FOREIGN KEY (DNI_cliente) REFERENCES CLIENTES(DNI) ON DELETE CASCADE,
CONSTRAINT fk2_apuestas FOREIGN KEY (cod_caballo) REFERENCES CABALLOS(cod_caballo) ON DELETE CASCADE,
CONSTRAINT fk3_apuestas FOREIGN KEY (cod_carrera) REFERENCES CARRERAS(cod_carrera) ON DELETE CASCADE
);


















