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


--1. Para cada titulación ordenar por coste mostrando primero las asignaturas más caras y 
--para las asignaturas del mismo coste mostrar por orden alfabético de nombre de asignatura. 
SELECT NOMBRE,COSTEBASICO FROM ASIGNATURA ORDER BY COSTEBASICO DESC, NOMBRE ASC;

--2. Mostrar el nombre y los apellidos de los profesores. 
SELECT P.NOMBRE, P.APELLIDO FROM PROFESOR PR, PERSONA P WHERE PR.DNI=P.DNI;

--3. Mostrar el nombre de las asignaturas impartidas por profesores de Sevilla. 
SELECT DISTINCT A.NOMBRE FROM ASIGNATURA A, PROFESOR PR, PERSONA P WHERE PR.DNI=P.DNI AND UPPER(P.CIUDAD) LIKE('SEVILLA');

--4. Mostrar el nombre y los apellidos de los alumnos.
SELECT P.NOMBRE,P.APELLIDO FROM ALUMNO AL, PERSONA P WHERE AL.DNI=P.DNI;

--5. Mostrar el DNI, nombre y apellidos de los alumnos que viven en Sevilla. 
SELECT P.DNI,P.NOMBRE,P.APELLIDO FROM ALUMNO AL, PERSONA P WHERE AL.DNI=P.DNI AND UPPER(P.CIUDAD) LIKE('SEVILLA');

--6. Mostrar el DNI, nombre y apellidos de los alumnos matriculados en la asignatura "Seguridad Vial". 
SELECT P.DNI,P.NOMBRE,P.APELLIDO FROM ALUMNO AL, PERSONA P, ASIGNATURA A, ALUMNO_ASIGNATURA AA 
WHERE AL.DNI=P.DNI AND AL.IDALUMNO=AA.IDALUMNO AND AA.IDASIGNATURA=A.IDASIGNATURA AND A.NOMBRE LIKE('Seguridad Vial');

--7. Mostrar el Id de las titulaciones en las que está matriculado el alumno con DNI 20202020A. 
--Un alumno está matriculado en una titulación si está matriculado en una asignatura de la titulación.
SELECT DISTINCT TI.IDTITULACION FROM TITULACION TI, ALUMNO AL, ASIGNATURA ASI, ALUMNO_ASIGNATURA AA
WHERE AL.DNI LIKE('20202020A') AND AL.IDALUMNO=AA.IDALUMNO AND AA.IDASIGNATURA=ASI.IDASIGNATURA AND ASI.IDTITULACION=TI.IDTITULACION;

--8. Obtener el nombre de las asignaturas en las que está matriculada Rosa Garcia.
SELECT DISTINCT ASI.NOMBRE FROM ASIGNATURA ASI, PERSONA PE, ALUMNO AL, ALUMNO_ASIGNATURA AA
WHERE PE.NOMBRE='Rosa' AND PE.APELLIDO='Garcia' AND PE.DNI=AL.DNI AND AL.IDALUMNO=AA.IDALUMNO AND AA.IDASIGNATURA=ASI.IDASIGNATURA;

--9. Obtener el DNI de los alumnos a los que le imparte clase el profesor Jorge Saenz. 
SELECT AL.DNI FROM ALUMNO AL, PROFESOR PR, PERSONA PE, ASIGNATURA ASI, ALUMNO_ASIGNATURA AA
WHERE PE.NOMBRE LIKE ('Jorge') AND PE.APELLIDO LIKE('Saenz') AND PE.DNI=PR.DNI AND PR.IDPROFESOR=ASI.IDPROFESOR AND ASI.IDASIGNATURA=AA.IDASIGNATURA AND AA.IDALUMNO=AL.IDALUMNO;

--10. Obtener el DNI, nombre y apellido de los alumnos a los que imparte clase el profesor Jorge Sáenz.
SELECT AL.DNI, PE2.NOMBRE, PE2.APELLIDO FROM ALUMNO AL, PROFESOR PR, PERSONA PE, PERSONA PE2, ASIGNATURA ASI, ALUMNO_ASIGNATURA AA
WHERE PE.NOMBRE LIKE ('Jorge') AND PE.APELLIDO LIKE('Saenz') AND PE.DNI=PR.DNI AND PR.IDPROFESOR=ASI.IDPROFESOR AND ASI.IDASIGNATURA=AA.IDASIGNATURA AND AA.IDALUMNO=AL.IDALUMNO AND AL.DNI=PE2.DNI;

--11. Mostrar el nombre de las titulaciones que tengan al menos una asignatura de 4 créditos. 
SELECT DISTINCT TI.NOMBRE FROM TITULACION TI, ASIGNATURA ASI
WHERE TI.IDTITULACION=ASI.IDTITULACION AND CREDITOS=4;

--12. Mostrar el nombre y los créditos de las asignaturas del primer cuatrimestre junto con el nombre de la titulación a la que pertenecen. 
SELECT DISTINCT ASI.NOMBRE, ASI.CREDITOS, TI.NOMBRE FROM TITULACION TI, ASIGNATURA ASI
WHERE TI.IDTITULACION=ASI.IDTITULACION AND CUATRIMESTRE=1;

--13. Mostrar el nombre y el coste básico de las asignaturas de más de 4,5 créditos junto con el nombre de las personas matriculadas
SELECT DISTINCT ASI.NOMBRE, ASI.COSTEBASICO, PE.NOMBRE FROM ASIGNATURA ASI, PERSONA PE, ALUMNO AL, ALUMNO_ASIGNATURA AA
WHERE CREDITOS>4.5 AND ASI.IDASIGNATURA=AA.IDASIGNATURA AND AA.IDALUMNO=AL.IDALUMNO AND AL.DNI=PE.DNI;

--14. Mostrar el nombre de los profesores que imparten asignaturas con coste entre 25 y 35 euros, ambos incluidos
SELECT DISTINCT PE.NOMBRE FROM PERSONA PE, PROFESOR PR, ASIGNATURA ASI
WHERE (COSTEBASICO BETWEEN 25 AND 35) AND ASI.IDPROFESOR=PR.IDPROFESOR AND PR.DNI=PE.DNI;

--15. Mostrar el nombre de los alumnos matriculados en la asignatura '150212' ó en la '130113' ó en ambas.
SELECT DISTINCT PE.NOMBRE FROM ALUMNO AL, ALUMNO_ASIGNATURA AA, PERSONA PE, ASIGNATURA ASI
WHERE ASI.IDASIGNATURA='150212' OR ASI.IDASIGNATURA='130113' AND ASI.IDASIGNATURA=AA.IDASIGNATURA AND AA.IDALUMNO=AL.IDALUMNO AND AL.DNI=PE.DNI;

--16. Mostrar el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos, junto con el nombre de la titulación a la que pertenece.
SELECT DISTINCT ASI.NOMBRE, TI.NOMBRE FROM ASIGNATURA ASI, TITULACION TI
WHERE CUATRIMESTRE=2 AND CREDITOS!=6 AND TI.IDTITULACION=ASI.IDTITULACION;

--17. Mostrar el nombre y el número de horas de todas las asignaturas. (1cred.=10 horas) junto con el dni de los alumnos que están matriculados.
SELECT ASI.NOMBRE, PE.DNI FROM ASIGNATURA ASI, PERSONA PE, ALUMNO AL, ALUMNO_ASIGNATURA AA
WHERE ASI.IDASIGNATURA=AA.IDASIGNATURA AND AA.IDALUMNO=AL.IDALUMNO AND AL.DNI=PE.DNI;

--18. Mostrar el nombre de todas las mujeres que viven en “Sevilla” y que estén matriculados de alguna asignatura
SELECT PE.NOMBRE FROM PERSONA PE, ALUMNO AL, ALUMNO_ASIGNATURA AA
WHERE PE.VARON=0 
AND UPPER(PE.CIUDAD) LIKE('SEVILLA') 
AND AA.NUMEROMATRICULA LIKE ('%') 
AND PE.DNI=AL.DNI 
AND AL.IDALUMNO=AA.IDALUMNO;

--19. Mostrar el nombre de la asignatura de primero y que lo imparta el profesor con identificador p101.
SELECT ASI.NOMBRE FROM ASIGNATURA ASI, PROFESOR PR
WHERE ASI.CURSO=1 
AND PR.IDPROFESOR='P101' 
AND PR.IDPROFESOR=ASI.IDPROFESOR;

--20. Mostrar el nombre de los alumnos que se ha matriculado tres o más veces en alguna asignatura.
SELECT PE.NOMBRE FROM PERSONA PE, ALUMNO_ASIGNATURA AA, ALUMNO AL
WHERE AA.NUMEROMATRICULA>=3 
AND AA.IDALUMNO=AL.IDALUMNO 
AND AL.DNI=PE.DNI;






