--1. Va a imprimir 'Cierto'
BEGIN
 IF 10 > 5 THEN
 DBMS_OUTPUT.PUT_LINE ('Cierto');
 ELSE
 DBMS_OUTPUT.PUT_LINE ('Falso');
 END IF;
END;
/

--2. Va a imprimir 'Cierto'
BEGIN
IF 10 > 5 AND 5 > 1 THEN
 DBMS_OUTPUT.PUT_LINE ('Cierto');
ELSE
 DBMS_OUTPUT.PUT_LINE ('Falso');
END IF;
END;
/

--3. Va a imprimir 'Falso'
BEGIN
IF 10 > 5 AND 5 > 50 THEN
 DBMS_OUTPUT.PUT_LINE ('Cierto');
ELSE
 DBMS_OUTPUT.PUT_LINE ('Falso');
END IF;
END;
/

--4. Imprime 'Falso'
BEGIN
CASE
 WHEN 10 > 5 AND 5 > 50 THEN
 DBMS_OUTPUT.PUT_LINE ('Cierto');
 ELSE
 DBMS_OUTPUT.PUT_LINE ('Falso');
END CASE;
END;
/

--5. Va a imprimir 1,2,3,4,5,6,7,8,9,10
BEGIN
 FOR i IN 1..10 LOOP
 DBMS_OUTPUT.PUT_LINE (i);
 END LOOP;
END;
/

--6. Va a imprimir del 10 al 1
BEGIN
 FOR i IN REVERSE 1..10 LOOP
 DBMS_OUTPUT.PUT_LINE (i);
 END LOOP;
END;

--7. Recorre el bucle, va sumandole 2 al número y lo va imprimiendo
DECLARE
 num NUMBER(3) := 0;
BEGIN
 WHILE num<=100 LOOP
 DBMS_OUTPUT.PUT_LINE (num);
 num:= num+2;
 END LOOP;
END;
/

--8. Recorre el bucle, va imprimiendo el número y sumandole dos. Cuando el numero es mayor de 100 sale del bucle
DECLARE
 num NUMBER(3) := 0;
BEGIN
 LOOP
 DBMS_OUTPUT.PUT_LINE (num);
 IF num > 100 THEN EXIT; END IF;
 num:= num+2;
 END LOOP;
END;
/

--9. Mismo procedimiento que en el ejercicio 8 pero sustituimos el if por un exit when
DECLARE
 num NUMBER(3) := 0;
BEGIN
 LOOP
 DBMS_OUTPUT.PUT_LINE (num);
 EXIT WHEN num > 100;
 num:= num+2;
 END LOOP;
END;
/




