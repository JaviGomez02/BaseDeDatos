CREATE TABLE FABRICANTES
(cod_fabricante NUMBER(3) NOT NULL,
nombre VARCHAR2(15),
pais VARCHAR2(15),
CONSTRAINT pk_fabricantes PRIMARY KEY (cod_fabricante),
CONSTRAINT condicion1_fabricantes CHECK (nombre=UPPER(nombre)),
CONSTRAINT condicion2_fabricantes CHECK (pais=UPPER(pais))
);

CREATE TABLE ARTICULOS
(articulo VARCHAR2(20) NOT NULL,
cod_fabricante NUMBER(3) NOT NULL,
peso NUMBER(3) NOT NULL,
categoria VARCHAR2(10) NOT NULL,
precio_venta NUMBER(4,2),
precio_costo NUMBER(4,2),
existencias NUMBER(5),
CONSTRAINT pk_articulos PRIMARY KEY (articulo,cod_fabricante,peso,categoria),
CONSTRAINT fk_articulos FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante),
CONSTRAINT condicion1_articulos CHECK (precio_venta>0),
CONSTRAINT condicion2_articulos CHECK (precio_costo>0),
CONSTRAINT condicion3_articulos CHECK (peso>0),
CONSTRAINT condicion4_articulos CHECK (categoria IN ('PRIMERA','SEGUNDA','TERCERA'))
);

CREATE TABLE TIENDAS
(nif VARCHAR2(10) NOT NULL,
nombre VARCHAR2(20),
direccion VARCHAR2(20),
poblacion VARCHAR2(20),
provincia VARCHAR2(20),
codpostal NUMBER(5),
CONSTRAINT pk_tiendas PRIMARY KEY (nif),
CONSTRAINT condicion1_tiendas CHECK (provincia=UPPER(provincia))
);

CREATE TABLE PEDIDOS
(nif VARCHAR2(10) NOT NULL,
articulo VARCHAR2(20) NOT NULL,
cod_fabricante NUMBER(3) NOT NULL,
peso NUMBER(3) NOT NULL,
categoria VARCHAR2(10) NOT NULL,
fecha_pedido DATE NOT NULL,
unidades_pedidas NUMBER(4),
CONSTRAINT pk_pedidos PRIMARY KEY (nif,articulo,cod_fabricante,peso,categoria,fecha_pedido),
CONSTRAINT fk1_pedidos FOREIGN KEY (articulo,cod_fabricante,peso,categoria) REFERENCES ARTICULOS(articulo,cod_fabricante,peso,categoria),
CONSTRAINT fk2_pedidos FOREIGN KEY (nif) REFERENCES TIENDAS(nif),
CONSTRAINT fk3_pedidos FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante),
CONSTRAINT condicion1_pedidos CHECK (unidades_pedidas>0)
);

CREATE TABLE VENTAS
(nif VARCHAR2(10) NOT NULL,
articulo VARCHAR2(20) NOT NULL,
cod_fabricante NUMBER(3) NOT NULL,
peso NUMBER(3) NOT NULL,
categoria VARCHAR2(10) NOT NULL,
fecha_venta DATE DEFAULT SYSDATE NOT NULL,
unidades_vendidas NUMBER(4),
CONSTRAINT pk_ventas PRIMARY KEY (nif,articulo,cod_fabricante,peso,categoria,fecha_venta),
CONSTRAINT fk1_ventas FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante),
CONSTRAINT condicion1_ventas CHECK (unidades_vendidas>0),
CONSTRAINT fk2_ventas FOREIGN KEY (articulo,cod_fabricante,peso,categoria) REFERENCES ARTICULOS(articulo,cod_fabricante,peso,categoria),
CONSTRAINT fk3_ventas FOREIGN KEY (nif) REFERENCES TIENDAS(nif)
);

ALTER TABLE VENTAS MODIFY unidades_vendidas NUMBER(6);

ALTER TABLE PEDIDOS MODIFY unidades_pedidas NUMBER(6);

ALTER TABLE VENTAS ADD pvp NUMBER(5);

ALTER TABLE PEDIDOS ADD pvp NUMBER(5);

ALTER TABLE FABRICANTES DROP COLUMN pais;

ALTER TABLE VENTAS ADD CONSTRAINT condicion2_ventas CHECK (unidades_vendidas>99);

ALTER TABLE VENTAS DROP CONSTRAINT condicion2_ventas;


/*DROP TABLE FABRICANTES CASCADE CONSTRAINT;
DROP TABLE ARTICULOS CASCADE CONSTRAINT;
DROP TABLE TIENDAS CASCADE CONSTRAINT;
DROP TABLE PEDIDOS CASCADE CONSTRAINT;
DROP TABLE VENTAS CASCADE CONSTRAINT;







