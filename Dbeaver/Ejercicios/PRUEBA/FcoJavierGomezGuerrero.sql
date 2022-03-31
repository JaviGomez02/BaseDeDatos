--1. Obtener las diferentes nacionalidades de películas que existen en la base de
--datos.
SELECT DISTINCT NACIONALIDAD FROM PELICULA;

--2. Mostrar el código de la película, la fecha de estreno y la recaudación de las
--películas ordenadas por su recaudación de mayor a menor estrenadas antes del 22
--de septiembre de 1997.
SELECT DISTINCT CIP, FECHA_ESTRENO, RECAUDACION
FROM PROYECCION
WHERE FECHA_ESTRENO<TO_DATE('22/09/1997','DD/MM/YYYY')
ORDER BY RECAUDACION DESC;

--3. Mostrar el código de las películas, la recaudación y el número de espectadores
--cuyo número de espectadores sea mayor que 3000 o cuya recaudación sea mayor o
--igual que 2000000, ordenadas de mayor a menor número de espectadores.
SELECT DISTINCT CIP, RECAUDACION, ESPECTADORES
FROM PROYECCION
WHERE ESPECTADORES>3000
OR RECAUDACION>=2000000
ORDER BY ESPECTADORES DESC;

--4. Obtener el nombre de los cines que contengan la cadena "ar" en mayúsculas o
--minúsculas en su dirección.
SELECT CINE 
FROM CINE
WHERE UPPER(DIRECCION_CINE) LIKE('%AR%');

--5. Mostrar los cines y su aforo total cuyo aforo total sea mayor que 600 ordenados
--por su aforo total de forma descendente.
SELECT s.CINE, SUM(s.AFORO) AS AFORO_TOTAL
FROM SALA s 
GROUP BY s.CINE
HAVING SUM(s.AFORO)>600
ORDER BY SUM(s.AFORO) DESC;

--6. Obtener el título de las películas estrenadas en la primera quincena de cualquier
--mes.
SELECT DISTINCT p.TITULO_P
FROM PELICULA p, PROYECCION p2 
WHERE EXTRACT(DAY FROM p2.FECHA_ESTRENO)<=15
AND p.CIP=p2.CIP;

--7. Muestra la nacionalidad de las películas junto con la media del presupuesto por
--cada nacionalidad teniendo en cuenta los valores nulos y teniendo en cuenta sólo
--aquellas películas cuyo presupuesto es mayor que 500;
SELECT NACIONALIDAD, AVG(NVL(PRESUPUESTO,0)) AS MEDIA_PRESUPUESTO
FROM PELICULA
WHERE PRESUPUESTO>500
GROUP BY NACIONALIDAD;

--8. 8. Obtener el nombre y el sexo de todos los personajes cuyo nombre termine en 'n',
--'s' o 'e' y no tengan sexo asignado.
SELECT NOMBRE_PERSONA, SEXO_PERSONA
FROM PERSONAJE
WHERE (NOMBRE_PERSONA LIKE('%n') OR NOMBRE_PERSONA LIKE('%s') OR NOMBRE_PERSONA LIKE('%e'))
AND SEXO_PERSONA IS NULL;

--9. Mostrar el nombre de las películas que el número total de días que se han
--estrenado sea mayor de 50.
SELECT TITULO_P
FROM PELICULA p, PROYECCION p2
WHERE p.CIP=p2.CIP
GROUP BY TITULO_P
HAVING SUM(DIAS_ESTRENO)>50;

--10. Mostrar el nombre del cine, junto con su dirección y la ciudad en la que está,
--junto con la sala y el aforo de la sala, y el nombre de las películas que se han
--proyectado en esa sala. Los datos deben salir ordenados por el nombre del cine, la
--sala del cine y por último el nombre de la película (puedes usar el nombre en
--versión original o en español como quieras).
SELECT c.CINE, c.DIRECCION_CINE, c.CIUDAD_CINE, s.SALA, s.AFORO, p.TITULO_P
FROM CINE c, SALA s, PELICULA p, PROYECCION p2
WHERE c.CINE=s.CINE
AND s.SALA=p2.SALA
AND p2.CIP=p.CIP
ORDER BY c.CINE, s.SALA, p.TITULO_P;

--11. Realizar una consulta que muestre por cada uno de los posibles trabajos(tareas)
--que se pueden realizar en nuestra base de datos, el número de personas que han
--realizado dicho trabajo.
--Ten en cuenta que si una persona ha realizado dos veces el mismo trabajo sólo
--deberá salir una vez.
SELECT DISTINCT t.TAREA, COUNT(t2.NOMBRE_PERSONA) AS NUMERO_PERSONAS
FROM TAREA t, TRABAJO t2 
WHERE t.TAREA=t2.TAREA
GROUP BY t.TAREA;

--12. Mostrar todos los datos de las películas estrenadas entre el 20 de septiembre de
--1995 y el 15 de diciembre de 1995. Si la película se ha estrenado dos o más veces
--en esas fechas sólo debe salir una vez.
SELECT DISTINCT p.*
FROM PELICULA p, PROYECCION p2
WHERE p2.FECHA_ESTRENO BETWEEN TO_DATE('20/09/1995','DD/MM/YYYY') AND TO_DATE('15/12/1995','DD/MM/YYYY')
AND p2.CIP=p.CIP;

--13. Mostrar el nombre de los cines y la ciudad en la que se han proyectado 22 o
--más películas distintas en todas sus salas.
SELECT c.CINE, c.CIUDAD_CINE
FROM CINE c, SALA s, PROYECCION p 
WHERE c.CINE=s.CINE
AND s.SALA=p.SALA
GROUP BY c.CINE, c.CIUDAD_CINE
HAVING COUNT(p.CIP)>=22;

--14. Obtener el nombre de la película y el presupuesto de todas las películas
--americanas estrenadas en un cine de Córdoba, sabiendo que Córdoba está escrito
--sin tilde en la base de datos y puede estar en mayúsculas o minúsculas.
SELECT DISTINCT p.TITULO_P, p.PRESUPUESTO
FROM PELICULA p, PROYECCION p2, SALA s, CINE c 
WHERE p.CIP=p2.CIP
AND p2.SALA=s.SALA
AND s.CINE=c.CINE
AND UPPER(NACIONALIDAD) LIKE('EE.UU')
AND UPPER(CIUDAD_CINE) LIKE('CORDOBA');

--15. 15. Obtener el título y la recaudación total obtenida por películas que contengan en
--su TITULO_P la cadena 'vi' en minúsculas o el número 7.
SELECT p.TITULO_P, SUM(p2.RECAUDACION)
FROM PELICULA p, PROYECCION p2
WHERE p.CIP=p2.CIP
AND TITULO_P LIKE('%vi%') 
OR TITULO_P LIKE('%7%')
GROUP BY TITULO_P;

--16. Obtener el presupuesto máximo y el presupuesto mínimo para las películas.
--Deberás utilizar los alias necesarios.
SELECT TITULO_P,MAX(PRESUPUESTO) AS PRESUPUESTO_MAXIMO, MIN(PRESUPUESTO) AS PRESUPUESTO_MINIMO
FROM PELICULA
GROUP BY TITULO_P;

--17. Explica en qué consiste el OUTER JOIN e indica un ejemplo justificándolo e
--incluyendo la sentencia correspondiente.

/*El outer join se utiliza para unir tablas que tienen en sus campos valores nulos.
Se usa poniendo al lado del nombre el siguiente símbolo: (+)

Por ejemplo, en el ejercicio 19 tenemos que usar un outer join para seleccionar los
datos de las películas que no tienen proyeccion. Ponemos el operador (+) al lado
de el campo CIP de la tabla PROYECCION:*/
SELECT *
FROM PELICULA p, PROYECCION p2
WHERE p.CIP=p2.CIP(+);

--18. Se desea obtener un listado de todas las proyecciones, adicionalmente deberá
--aparecer en el listado otra columna que se llame fecha_estimada y cuyos valores a
--mostrar sean la fecha de estreno con un incremento de 2 meses
SELECT CINE,SALA,CIP,FECHA_ESTRENO,DIAS_ESTRENO,ESPECTADORES,RECAUDACION, ADD_MONTHS(FECHA_ESTRENO,2) AS FECHA_ESTIMADA
FROM PROYECCION;

--19. Mostrar todos los datos de películas junto con los datos de sus proyecciones. En
--este listado deben aparecer tanto las películas que tienes proyecciones como las
--que no tienen proyección.
SELECT *
FROM PELICULA p, PROYECCION p2
WHERE p.CIP=p2.CIP(+);

--20. Muestra el número de personajes que trabajan por cada película junto a su título
--principal ordenados por nombre de película (titulo_p) de forma ascendente.
SELECT COUNT(t.NOMBRE_PERSONA) AS NUMERO_TRABAJADORES, p.TITULO_P
FROM TRABAJO t, PELICULA p 
WHERE t.CIP=p.CIP
GROUP BY p.TITULO_P
ORDER BY p.TITULO_P ASC;












