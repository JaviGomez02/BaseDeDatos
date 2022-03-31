CREATE TABLE VEHICULO
(matricula varchar2(7),
marca varchar2(10) NOT NULL,
modelo varchar2(10) NOT NULL,
fecha_compra DATE,
precio_por_dia number(5,2),
CONSTRAINT pk_vehiculo PRIMARY KEY (matricula),
CONSTRAINT ch_veh_fec CHECK (EXTRACT(YEAR FROM fecha_compra) >= 2001),
CONSTRAINT ch_veh_pre CHECK (precio_por_dia > 0)
)

CREATE TABLE CLIENTE
(dni varchar2(9),
nombre varchar2(30) NOT NULL,
nacionalidad varchar2(30),
fecha_nac DATE,
direccion varchar2(50),
CONSTRAINT pk_cliente PRIMARY KEY (dni)
)

CREATE TABLE ALQUILER(
matricula varchar2(7) NOT NULL,
dni varchar2(10) NOT NULL,
fechahora DATE,
num_dias number(2) NOT NULL,
kilometros number(4),
CONSTRAINT pk_alquiler PRIMARY KEY (matricula, dni, fechahora),
CONSTRAINT fk1_alquiler FOREIGN KEY (matricula) REFERENCES VEHICULO(matricula),
CONSTRAINT fk2_alquiler FOREIGN KEY (dni) REFERENCES CLIENTE(dni)
)