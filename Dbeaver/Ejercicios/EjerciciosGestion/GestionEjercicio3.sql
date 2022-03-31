--1. Descuento medio aplicado en las facturas.
SELECT AVG(DTO) FROM FACTURAS;

--2. Descuento medio aplicado en las facturas sin considerar los valores nulos.
SELECT AVG(DTO) FROM FACTURAS
WHERE DTO IS NOT NULL;

--3. Descuento medio aplicado en las facturas considerando los valores nulos como cero.
SELECT AVG(NVL(DTO,0)) FROM FACTURAS;

--4. Número de facturas.
SELECT COUNT(CODFAC) FROM FACTURAS;

--5. Número de pueblos de la Comunidad de Valencia.
SELECT COUNT(CODPUE) FROM PUEBLOS PU, PROVINCIAS PR
WHERE PR.CODPRO=PU.CODPRO
AND UPPER(PR.NOMBRE)='VALENCIA';

--6. Importe total de los artículos que tenemos en el almacén. 
--Este importe se calcula sumando el producto de las unidades en stock por el precio de cada unidad
SELECT SUM(STOCK+PRECIO) AS IMPORTETOTAL FROM ARTICULOS;

--7. Número de pueblos en los que residen clientes cuyo código postal empieza por ‘12’.
SELECT COUNT(PU.CODPUE) FROM PUEBLOS PU, CLIENTES CLI
WHERE PU.CODPUE=CLI.CODPUE
AND CLI.CODPOSTAL LIKE('12%');

--8. Valores máximo y mínimo del stock de los artículos cuyo precio oscila entre 9 y 12 € y diferencia entre ambos valores
SELECT CODART, STOCK, STOCK_MIN, STOCK-STOCK_MIN AS DIFERENCIA FROM ARTICULOS
WHERE PRECIO BETWEEN 9 AND 12;

--9. Precio medio de los artículos cuyo stock supera las 10 unidades.
SELECT AVG(PRECIO) FROM ARTICULOS
WHERE STOCK>10;

--10. Fecha de la primera y la última factura del cliente con código 210.
--Mal
SELECT MAX(FECHA), MIN(FECHA) FROM FACTURAS FA,CLIENTES CL
WHERE FA.CODCLI = CL.CODCLI 
AND CL.CODCLI = 210;

--11. Número de artículos cuyo stock es nulo.
SELECT COUNT(CODART) FROM ARTICULOS
WHERE STOCK IS NULL;

--12. Número de líneas cuyo descuento es nulo (con un decimal)
SELECT COUNT(LINEA) FROM LINEAS_FAC
WHERE DTO IS NULL;

--13. Obtener cuántas facturas tiene cada cliente.
SELECT CL.CODCLI, COUNT(FA.CODFAC) FROM CLIENTES CL, FACTURAS FA
WHERE CL.CODCLI=FA.CODCLI
GROUP BY CL.CODCLI;

--14. Obtener cuántas facturas tiene cada cliente, pero sólo si tiene dos o más  facturas.
SELECT CL.CODCLI, COUNT(FA.CODFAC) FROM CLIENTES CL, FACTURAS FA
WHERE CL.CODCLI=FA.CODCLI
HAVING COUNT(FA.CODFAC)>=2
GROUP BY CL.CODCLI;

--15. Importe de la facturación (suma del producto de la cantidad por el precio de las líneas de factura) de los  artículos
SELECT CANT*LINEA, CODART FROM LINEAS_FAC;

--16. Importe de la facturación (suma del producto de la cantidad por el precio de las líneas de factura) 
--de aquellos artículos cuyo código contiene la letra “A” (bien mayúscula o minúscula).
SELECT CANT*LINEA, CODART FROM LINEAS_FAC;
WHERE UPPER(CODART) LIKE('%A%');

--17. Número de facturas para cada fecha, junto con la fecha
SELECT COUNT(CODFAC), FECHA FROM FACTURAS
GROUP BY FECHA;

--18. Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos que más clientes tengan.
SELECT COUNT(CL.CODCLI), PU.NOMBRE FROM CLIENTES CL, PUEBLOS PU
WHERE PU.CODPUE=CL.CODPUE
GROUP BY PU.NOMBRE
ORDER BY COUNT(CL.CODCLI) DESC;

--19. Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos que más clientes tengan, 
--siempre y cuando tengan más de dos clientes.
SELECT COUNT(CL.CODCLI), PU.NOMBRE FROM CLIENTES CL, PUEBLOS PU
WHERE PU.CODPUE=CL.CODPUE
GROUP BY PU.NOMBRE
HAVING COUNT(CL.CODCLI)>=2 
ORDER BY COUNT(CL.CODCLI) DESC;

--20. Cantidades totales vendidas para cada artículo cuyo código empieza por “P", mostrando también la descripción de dicho artículo.
--9.-	Precio máximo y precio mínimo de venta (en líneas de facturas) para cada artículo cuyo código empieza por “c”.
SELECT AR.CODART, COUNT(FA.CANT) FROM LINEAS_FAC FA, ARTICULOS AR
WHERE AR.CODART=FA.CODART
AND AR.CODART LIKE('P%')
GROUP BY AR.CODART;

SELECT LINEA, MAX(PRECIO), MIN(PRECIO) FROM LINEAS_FAC
WHERE CODART LIKE('C%')
GROUP BY LINEA;

--21. Igual que el anterior pero mostrando también la diferencia entre el precio máximo y mínimo.
SELECT LINEA, MAX(PRECIO), MIN(PRECIO), MAX(PRECIO)-MIN(PRECIO) AS DIFERENCIA FROM LINEAS_FAC
WHERE CODART LIKE('C%')
GROUP BY LINEA;

--22. Nombre de aquellos artículos de los que se ha facturado más de 10000 euros.
SELECT AR.DESCRIP FROM LINEAS_FAC FA, ARTICULOS AR
WHERE AR.CODART=FA.CODART
AND AR.PRECIO*FA.CANT > 10000;

--23. Número de facturas de cada uno de los clientes cuyo código está entre 150 y 300 (se debe mostrar este código), con cada IVA distinto que se les ha aplicado.
SELECT COUNT(CODFAC),CODFAC FROM FACTURAS FA, CLIENTES CL
WHERE FA.CODCLI=CL.CODCLI 
AND CL.CODCLI BETWEEN 150 AND 300
GROUP BY CODFAC;

--24. Media del importe de las facturas, sin tener en cuenta impuestos ni descuentos.
SELECT AVG(CANT*LINEA) AS IMPORTE FROM lineas_fac;
