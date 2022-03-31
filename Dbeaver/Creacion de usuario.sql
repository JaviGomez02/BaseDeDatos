alter session set "_oracle_script"=true;  
create user coches identified by coches;
GRANT CONNECT, RESOURCE, DBA TO coches;
