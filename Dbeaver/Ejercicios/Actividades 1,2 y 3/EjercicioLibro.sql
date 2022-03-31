CREATE TABLE TEMA
(cod_tema NUMBER(10),
denominacion VARCHAR2(100),
cod_tema_padre NUMBER(10),
CONSTRAINT pk_tema PRIMARY KEY (cod_tema),
CONSTRAINT fk_tema FOREIGN KEY (cod_tema_padre) REFERENCES TEMA(cod_tema),
CONSTRAINT condicion_cod_tema_padre CHECK (cod_tema_padre >= cod_tema)
)

CREATE TABLE AUTOR
(cod_autor NUMBER(10),
nombre VARCHAR2(20),
f_nacimiento DATE,
libro_principal NUMBER(10),
CONSTRAINT pk_autor PRIMARY KEY (cod_autor)
)

CREATE TABLE LIBRO
(cod_libro NUMBER(10),
titulo VARCHAR2(20),
f_creacion DATE,
cod_tema NUMBER(10),
autor_principal NUMBER(10),
CONSTRAINT pk_libro PRIMARY KEY (cod_libro),
CONSTRAINT fk1_libro FOREIGN KEY (cod_tema) REFERENCES TEMA(cod_tema),
CONSTRAINT fk2_libro FOREIGN KEY (autor_principal) REFERENCES AUTOR(cod_autor)
)

CREATE TABLE LIBRO_AUTOR
(cod_libro NUMBER(10),
cod_autor NUMBER(10),
orden NUMBER(1),
CONSTRAINT pk_libro_autor PRIMARY KEY (cod_libro, cod_autor),
CONSTRAINT fk1_libro_autor FOREIGN KEY (cod_libro) REFERENCES LIBRO(cod_libro),
CONSTRAINT fk2_libro_autor FOREIGN KEY (cod_autor) REFERENCES AUTOR(cod_autor),
CONSTRAINT condicion_orden CHECK (orden >=1 AND orden<=5)
)

CREATE TABLE EDITORIAL
(cod_editorial NUMBER(10),
denominacion VARCHAR2(20),
CONSTRAINT pk_editorial PRIMARY KEY (cod_editorial)
)

CREATE TABLE PUBLICACIONES
(cod_editorial NUMBER(10),
cod_libro NUMBER(10),
precio NUMBER(10,2),
f_publicacion DATE,
CONSTRAINT pk_publicaciones PRIMARY KEY (cod_editorial, cod_libro),
CONSTRAINT fk1_publicaciones FOREIGN KEY (cod_editorial) REFERENCES EDITORIAL(cod_editorial),
CONSTRAINT fk2_publicaciones FOREIGN KEY (cod_libro) REFERENCES LIBRO(cod_libro)
)

ALTER TABLE AUTOR ADD CONSTRAINT fk_AUTOR FOREIGN KEY (libro_principal) REFERENCES LIBRO(cod_libro);



