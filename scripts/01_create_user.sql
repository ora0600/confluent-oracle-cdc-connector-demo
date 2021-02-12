--------------------------------------------------------------------------------------
-- Name	       : OT (Oracle Tutorial) Sample Database
--------------------------------------------------------------------
-- execute the following statements to create a user name OT and
-- grant priviledges
--------------------------------------------------------------------

-- create new user
Create user ordermgmt identified by kafka;

-- grant priviledges
grant RESOURCE to ordermgmt;
grant create session to ordermgmt;

-- give right to write data to tablespace
alter user ordermgmt quota 50m on USERS;