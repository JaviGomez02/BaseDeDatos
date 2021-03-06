/*drop table alumno_asignatura;
drop table asignatura;
drop table alumno;
drop table profesor;
drop table persona;
drop table titulacion;*/

Create table titulacion (
Idtitulacion varchar2(6) primary key,
Nombre varchar2(30)
);


Create table persona (
dni varchar2(11) primary key,
Nombre varchar2(30),
Apellido varchar2(30),
Ciudad varchar2(15),
Direccioncalle varchar2(30),
Direccionnum number,
Telefono varchar2(9),
Fecha_nacimiento date,
Varon number
);



create table alumno (
idalumno varchar2(7) primary key,
dni varchar2(11),
foreign key (dni) references persona(dni)
);

Create table profesor (
Idprofesor varchar2(4) primary key,
Dni varchar2(11),
Foreign key(dni) references persona(dni)
);

Create table asignatura (
Idasignatura varchar2(6) primary key,
Nombre varchar2(20),
Creditos number,
Cuatrimestre number,
Costebasico number,
Idprofesor varchar2(4),
Idtitulacion varchar2(6),
Curso number,
Foreign key(idprofesor) references profesor(idprofesor),
Foreign key (idtitulacion) references titulacion(idtitulacion)
);

Create table  alumno_asignatura (
Idalumno varchar2(7),
Idasignatura varchar2(6),
Numeromatricula number,
  PRIMARY KEY(idalumno,idasignatura,numeromatricula),
Foreign key(idalumno) references alumno(idalumno),
Foreign key(idasignatura) references asignatura(idasignatura)
);


insert into persona values ('16161616A','Luis','Ramirez','Haro','Pez','34','941111111',to_date('1/1/1969','dd/mm/yyyy'),'1');
insert into persona values ('17171717A','Laura','Beltran','Madrid','Gran Va','23','912121212',to_date('8/8/1974','dd/mm/yyyy'),'0');
insert into persona values ('18181818A','Pepe','Perez','Madrid','Percebe','13','913131313',to_date('2/2/1980','dd/mm/yyyy'),'1');
insert into persona values ('19191919A','Juan','Sanchez','Bilbao','Melancola','7','944141414',to_date('3/2/1966','dd/mm/yyyy'),'1');
insert into persona values ('20202020A','Luis','Jimenez','Najera','Cigea','15','941151515',to_date('3/3/1979','dd/mm/yyyy'),'1');
insert into persona values ('21212121A','Rosa','Garcia','Haro','Alegra','16','941161616',to_date('4/4/1978','dd/mm/yyyy'),'0');
insert into persona values ('23232323A','Jorge','Saenz','Sevilla','Luis Ulloa','17','941171717',to_date('9/9/1978','dd/mm/yyyy'),'1');
insert into persona values ('24242424A','Mara','Gutierrez','Sevilla','Avda. de la Paz','18','941181818',to_date('10/10/1964','dd/mm/yyyy'),'0');
insert into persona values ('25252525A','Rosario','Diaz','Sevilla','Percebe','19','941191919',to_date('11/11/1971','dd/mm/yyyy'),'0');
insert into persona values ('26262626A','Elena','Gonzalez','Sevilla','Percebe','20','941202020',to_date('5/5/1975','dd/mm/yyyy'),'0');


insert into alumno values ('A010101','21212121A');
insert into alumno values ('A020202','18181818A');
insert into alumno values ('A030303','20202020A');
insert into alumno values ('A040404','26262626A');
insert into alumno values ('A121212','16161616A');
insert into alumno values ('A131313','17171717A');


insert into profesor values ('P101','19191919A');
insert into profesor values ('P117','25252525A');
insert into profesor values ('P203','23232323A');
insert into profesor values ('P204','26262626A');
insert into profesor values ('P304','24242424A');


insert into titulacion values ('130110','Matematicas');
insert into titulacion values ('150210','Quimicas');
insert into titulacion values ('160000','Empresariales');


insert into asignatura values ('000115','Seguridad Vial','4','1','30 ','P204',null,null);
insert into asignatura values ('130113','Programacion I', '9','1','60 ','P101','130110','1');
insert into asignatura values ('130122','Analisis II',    '9','2','60 ','P203','130110','2');
insert into asignatura values ('150212','Quimica Fisica','4','2','70','P304','150210','1');
insert into asignatura values ('160002','Contabilidad','6','1','70','P117','160000','1');


insert into alumno_asignatura values('A010101','150212','1');
insert into alumno_asignatura values('A020202','130113','1');
insert into alumno_asignatura values('A020202','150212','2');
insert into alumno_asignatura values('A030303','130113','3');
insert into alumno_asignatura values('A030303','150212','1');
insert into alumno_asignatura values('A030303','130122','2');
insert into alumno_asignatura values('A040404','130122','1');
insert into alumno_asignatura values('A121212','000115','1');
insert into alumno_asignatura values('A131313','160002','4');

--1. Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la '150212' y la '130113'.
SELECT IDALUMNO
FROM ALUMNO_ASIGNATURA
WHERE IDASIGNATURA NOT LIKE ('150212')
AND IDASIGNATURA NOT LIKE ('130113');

--2. Mostrar el nombre de las asignaturas que tienen m??s cr??ditos que "Seguridad Vial". 
SELECT NOMBRE
FROM ASIGNATURA
WHERE CREDITOS>(SELECT CREDITOS
				FROM ASIGNATURA
				WHERE UPPER(NOMBRE) LIKE ('%SEGURIDAD VIAL%'));

--3. Obtener el Id de los alumnos matriculados en las asignaturas "150212" y "130113" a la vez. 
SELECT IDALUMNO
FROM ALUMNO_ASIGNATURA
WHERE IDASIGNATURA LIKE ('150212') 
AND IDASIGNATURA LIKE ('130113');

--4. Mostrar el Id de los alumnos matriculados en las asignatura "150212" ?? "130113", 
--en una o en otra pero no en ambas a la vez. 
SELECT IDALUMNO
FROM ALUMNO_ASIGNATURA
WHERE IDASIGNATURA LIKE ('150212')
OR IDASIGNATURA LIKE ('130113');

--5. Mostrar el nombre de las asignaturas de la titulaci??n "130110" cuyos costes 
--b??sicos sobrepasen el coste  b??sico promedio por asignatura en esa titulaci??n.
SELECT a.NOMBRE
FROM ASIGNATURA a
WHERE A.IDTITULACION='130110'
AND a.COSTEBASICO>(SELECT AVG(NVL(A2.COSTEBASICO,0))
					FROM ASIGNATURA a2
					WHERE A2.IDTITULACION='130110');

--6. Mostrar el identificador de los alumnos matriculados en cualquier asignatura
--excepto la "150212" y la "130113???
SELECT IDALUMNO
FROM ALUMNO_ASIGNATURA
WHERE IDASIGNATURA NOT LIKE ('150212')
AND IDASIGNATURA NOT LIKE ('130113');

--7. Mostrar el Id de los alumnos matriculados en la asignatura "150212" pero no en la "130113".
SELECT IDALUMNO
FROM ALUMNO_ASIGNATURA
WHERE IDASIGNATURA='150212'
AND IDASIGNATURA!='130113';

--8. Mostrar el nombre de las asignaturas que tienen m??s cr??ditos que "Seguridad Vial".
SELECT NOMBRE
FROM ASIGNATURA
WHERE CREDITOS>(SELECT CREDITOS
				FROM ASIGNATURA
				WHERE UPPER(NOMBRE) LIKE('%SEGURIDAD VIAL%'));

--9. Mostrar las personas que no son ni profesores ni alumnos.
SELECT NOMBRE
FROM PERSONA
WHERE DNI NOT IN (SELECT DNI FROM PROFESOR)
AND DNI NOT IN (SELECT DNI FROM ALUMNO);

--10. Mostrar el nombre de las asignaturas que tengan m??s cr??ditos. 
SELECT NOMBRE
FROM ASIGNATURA
WHERE CREDITOS=(SELECT MAX(CREDITOS) FROM ASIGNATURA);

--11. Lista de asignaturas en las que no se ha matriculado nadie.
--???
SELECT a.NOMBRE
FROM ASIGNATURA a
WHERE a.IDASIGNATURA NOT IN (SELECT aa.IDASIGNATURA FROM ALUMNO_ASIGNATURA aa);

--12. Ciudades en las que vive alg??n profesor y tambi??n alg??n alumno
SELECT p.CIUDAD
FROM PERSONA p
WHERE P.DNI IN (SELECT P2.DNI FROM PROFESOR p2)
AND P.DNI IN (SELECT A.DNI FROM ALUMNO a);





