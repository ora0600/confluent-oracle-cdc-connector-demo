CREATE ROLE C##CDC_PRIVS;
GRANT CREATE SESSION, EXECUTE_CATALOG_ROLE, SELECT ANY TRANSACTION, SELECT ANY DICTIONARY TO C##CDC_PRIVS;
GRANT SELECT ANY TABLE to C##CDC_PRIVS;
GRANT SELECT ON SYSTEM.LOGMNR_COL$ TO C##CDC_PRIVS;
GRANT SELECT ON SYSTEM.LOGMNR_OBJ$ TO C##CDC_PRIVS;
GRANT SELECT ON SYSTEM.LOGMNR_USER$ TO C##CDC_PRIVS;
GRANT SELECT ON SYSTEM.LOGMNR_UID$ TO C##CDC_PRIVS;
GRANT LOGMINING TO C##CDC_PRIVS;

CREATE USER C##myuser IDENTIFIED BY confluent DEFAULT TABLESPACE USERS CONTAINER=ALL;
GRANT C##CDC_PRIVS TO C##myuser;
ALTER USER C##myuser QUOTA UNLIMITED ON USERS;
ALTER USER C##myuser SET CONTAINER_DATA = (CDB$ROOT, ORCLPDB1) CONTAINER=CURRENT;

ALTER SESSION SET CONTAINER=CDB$ROOT;
GRANT CREATE SESSION, ALTER SESSION, SET CONTAINER, LOGMINING, EXECUTE_CATALOG_ROLE TO C##myuser CONTAINER=ALL;
GRANT EXECUTE ON SYS.DBMS_LOGMNR TO C##myuser CONTAINER=ALL;
GRANT EXECUTE ON SYS.DBMS_LOGMNR_D TO C##myuser CONTAINER=ALL;
GRANT EXECUTE ON SYS.DBMS_LOGMNR_LOGREP_DICT TO C##myuser CONTAINER=ALL;
GRANT FLASHBACK ANY TABLE TO C##myuser  CONTAINER=ALL;
-- GRANT EXECUTE ON SYS.DBMS_LOGMNR_SESSION TO C##myuser CONTAINER=ALL;


GRANT SELECT ON GV_$DATABASE TO C##myuser CONTAINER=ALL;
GRANT SELECT ON V_$LOGMNR_CONTENTS TO C##myuser CONTAINER=ALL;
GRANT SELECT ON GV_$ARCHIVED_LOG TO C##myuser CONTAINER=ALL;
GRANT CONNECT TO C##myuser CONTAINER=ALL;
GRANT CREATE TABLE TO C##myuser CONTAINER=ALL;
GRANT CREATE SEQUENCE TO C##myuser CONTAINER=ALL;
GRANT CREATE TRIGGER TO C##myuser CONTAINER=ALL;
GRANT SELECT ANY TABLE TO C##myuser CONTAINER=ALL;
