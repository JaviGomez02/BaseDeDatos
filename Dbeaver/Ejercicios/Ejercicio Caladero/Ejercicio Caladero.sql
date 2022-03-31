CREATE TABLE BARCOS
(matricula VARCHAR2(7),
nombre VARCHAR2(30),
clase VARCHAR2(30),
armador VARCHAR2(30),
capacidad NUMBER(10),
nacionalidad VARCHAR2(20),
CONSTRAINT pk_barcos PRIMARY KEY (matricula),
CONSTRAINT condicion_barcos CHECK(regexp_like(matricula,'[A-Z]{2}[-][0-9]{4}'))
);

CREATE TABLE CALADERO
(codigo NUMBER(10),
nombre VARCHAR2(30),
ubicacion VARCHAR2(50),
especie_principal NUMBER(10),
CONSTRAINT pk_caladero PRIMARY KEY (codigo),
CONSTRAINT condicion1_caladero CHECK (nombre=UPPER(nombre)),
CONSTRAINT condicion2_caladero CHECK (ubicacion=UPPER(ubicacion))
);

CREATE TABLE ESPECIE
(codigo NUMBER(10),
nombre VARCHAR2(30),
tipo VARCHAR2(50),
cupoporbarco VARCHAR2(30),
caladero_principal NUMBER(10),
CONSTRAINT pk_especie PRIMARY KEY (codigo),
CONSTRAINT fk_especie FOREIGN KEY (caladero_principal) REFERENCES CALADERO(codigo)
);

CREATE TABLE LOTES
(codigo NUMBER(10),
matricula VARCHAR2(7),
numkilos NUMBER(10),
precioporkilosalida NUMBER(5,2),
precioporkiloadjudicado NUMBER(5,2),
fechaventa DATE NOT NULL,
cod_especie NUMBER(10),
CONSTRAINT pk_lotes PRIMARY KEY (codigo),
CONSTRAINT fk1_lotes FOREIGN KEY (matricula) REFERENCES BARCOS(matricula),
CONSTRAINT fk2_lotes FOREIGN KEY (cod_especie) REFERENCES ESPECIE(codigo),
CONSTRAINT condicion1_lotes CHECK (precioporkiloadjudicado>precioporkilosalida),
CONSTRAINT condicion2_lotes CHECK (numkilos>0),
CONSTRAINT condicion3_lotes CHECK (precioporkilosalida>0),
CONSTRAINT condicion4_lotes CHECK (precioporkiloadjudicado>0)
);

CREATE TABLE FECHAS_CAPTURAS_PERMITIDAS
(cod_especie NUMBER(10),
cod_caladero NUMBER(10),
fecha_inicial DATE,
fecha_final DATE,
CONSTRAINT pk_fechas PRIMARY KEY (cod_especie,cod_caladero),
CONSTRAINT fk1_fechas FOREIGN KEY (cod_especie) REFERENCES ESPECIE(codigo),
CONSTRAINT fk2_fechas FOREIGN KEY (cod_caladero) REFERENCES CALADERO(codigo)
);

ALTER TABLE CALADERO ADD CONSTRAINT fk_caladero FOREIGN KEY (especie_principal) REFERENCES ESPECIE(codigo);



ALTER TABLE CALADERO ADD nombre_cientifico VARCHAR2(30);

ALTER TABLE BARCOS DROP COLUMN armador;

ALTER TABLE FECHAS_CAPTURAS_PERMITIDAS ADD CONSTRAINT condicion1_fechas CHECK (TO_CHAR(fecha_inicial,'DD/MM') < '02/02' OR TO_CHAR(fecha_inicial,'DD/MM') > '28/03');   

ALTER TABLE FECHAS_CAPTURAS_PERMITIDAS ADD CONSTRAINT condicion2_fechas CHECK (TO_CHAR(fecha_final,'DD/MM') < '02/02' OR TO_CHAR(fecha_final,'DD/MM') > '28/03');       

DROP TABLE BARCOS CASCADE CONSTRAINT;
DROP TABLE CALADERO CASCADE CONSTRAINT;
DROP TABLE ESPECIE CASCADE CONSTRAINT;
DROP TABLE LOTES CASCADE CONSTRAINT;
DROP TABLE FECHAS_CAPTURAS_PERMITIDAS CASCADE CONSTRAINT;


