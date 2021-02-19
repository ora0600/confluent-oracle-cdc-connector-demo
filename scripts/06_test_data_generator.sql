-- Test Data Generator
-- see https://asktom.oracle.com/pls/apex/f?p=100:11:0::::P11_QUESTION_ID:2151576678914

create or replace procedure clone( p_tname in varchar2, p_records in number )
authid current_user
as
 l_insert long;
 l_insert_back long;
 l_rows number default 0;
begin
 -- clone table with data
 execute immediate 'create table clone_' || p_tname || ' as select * from ' || p_tname || ' where 1=0';
 l_insert := 'insert into clone_' || p_tname || ' select ';
 l_insert_back := 'insert into ' || p_tname || ' select ';

 for x in ( select COLUMN_NAME, data_type, data_length,
                   rpad( '9',data_precision,'9')/power(10,data_scale) maxval
              from user_tab_columns
             where table_name = 'CLONE_' || upper(p_tname)
             order by column_id 
           )loop
    -- Generate random values
    if ( x.data_type in ('NUMBER', 'FLOAT' )) then
        l_insert := l_insert || 'dbms_random.value(1,' || x.maxval ||'),';
    elsif ( x.data_type = 'DATE' ) then
        l_insert := l_insert || 'sysdate+dbms_random.value+dbms_random.value(1,1000),';
    else
        l_insert := l_insert || 'dbms_random.string(''A'',' || x.data_length || '),';
    end if;
    l_insert_back := l_insert_back || x.COLUMN_NAME ||',';
 end loop;
 l_insert := rtrim(l_insert,',') || ' from all_objects where rownum <= :n';
 l_insert_back := rtrim(l_insert_back,',') || ' from clone_' || p_tname;

 loop
    execute immediate l_insert using p_records - l_rows;
    l_rows := l_rows + sql%rowcount;
    exit when ( l_rows >= p_records );
 end loop;
 -- Now Insert new Values from clone table into orgin
 execute immediate l_insert_back;
 -- Drop cloned table
 execute immediate 'DROP table clone_' || p_tname ;
 commit;
end;
/