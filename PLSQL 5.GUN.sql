select /*+ result_cache */e1.department_id,sum(e1.salary),count(*)
from employees e1, employees e2, employees e3,employees e4
group by e1.department_id
order by 1,2,3;



create table tab1 (n number);
create table tab2 (n number);
create table tab3 (n number);

begin 
for i in 1..1000000 loop
  insert into tab1 values (i);
end loop;
commit;
end;
/

declare
type num_arr is table of number index by pls_integer;
v_nums num_arr;
begin
for i in 1..1000000 loop
  v_nums(i):=i;
end loop;
forall j in v_nums.first..v_nums.last 
insert into tab2 values (v_nums(j));
commit;
end;
/

drop table emp;
create table emp as select * from employees where 1=2;
select * from emp;

declare
type emp_arr is table of employees%rowtype;
v_emps emp_arr;
begin
select * bulk collect into v_emps from employees where salary > 5000;
forall i in v_emps.first..v_emps.last 
insert into emp values v_emps(i);
commit;
end;
/


declare
v_lname varchar2(50);
begin
update employees set salary=salary+ 500 where employee_id=167
returning last_name into v_lname;
yaz(v_lname);
end;
/


TRIGGERS   

DML TRIGGERS 
 

create or replace trigger trig1  
--TIMING  BEFORE / AFTER /INSTEAD OF 
after 
-- EVENT INSERT / UPDATE  / DELETE 
update 
-- RELATIONAL OBJECT (TABLE OR VIEW) 
on employees 
-- OPTIONS  ROW LEVEL / STATEMENT LEVEL 

--CODE  BEGI END;
begin
yaz('Update i?lemi gerçekle?tirildi');
end;
/

update employees set salary=1;


create or replace trigger trig1  
before update on employees 
for each row 
begin
yaz('Update i?lemi gerçekle?tirildi => oldvalue :'||:old.salary||'  newvalue :'||:new.salary);
end;
/


create or replace trigger trig1  
before update on employees 
for each row 
when (new.department_id<>90)
begin
yaz('Update i?lemi gerçekle?tirildi => oldvalue :'||:old.salary||'  newvalue :'||:new.salary);
end;
/

create or replace trigger trig1  
before update on employees 
begin
  raise_application_error(-20055,'bu tabloya update i?lemi yap?lamaz');
end;
/
select salary from employees;


create or replace trigger trig1  
before update on employees 
for each row 
declare
v_avg_salary number;
begin
select avg(salary) into v_avg_salary from employees;
if v_avg_salary < :new.salary then 
  yaz(:new.employee_id ||' nolu çal??an?n maa?? ortalamadan yüksek oldu');
end if;
end;
/

UPDATE EMPLOYEES SET SALARY=SALARY+500;

COMPOUND TRIGGERS 

create or replace trigger trig1 
for update on employees
compound trigger 

--Section 1 declare 
v_avg_sal number;
--Section 2 Before statement 
before statement is 
  begin
    select avg(salary) into v_avg_sal from employees;  
  end;
end before statement;
--Section 3 before each row 
before each row  is 
  begin
    if :new.salary > v_avg_sal then  
      yaz(:new.employee_id ||' no lu kullan?c? ortalamadan yüksek maa? ald?');
    end if;
  end;
end before each row;
--Section 4 after each row 
--Section 5 after statement 
end;





update employees e set salary = (select salary from employees 
                                 as of timestamp sysdate-1/24 
                                 where employee_id=e.employee_id);

commit;



update employees set salary=salary+2000;






DDL and DATABASE TRIGGERS 










select * from user_plsql_object_settings;
alter session set PLSQL_OPTIMIZE_LEVEL=2;
alter session set PLSQL_CODE_TYPE=NATIVE;

alter procedure print_data compile;

select * from v$block

alter session set PLSQL_WARNINGS='enable:all';


create or replace procedure test_warn_proc (p_clob in out CLOB)
is
v_lname varchar2(50);
begin
select last_name into v_lname from employees where employee_id=175;
if length(v_lname) > 4 then 
  raise_application_error(-20005,'HATA');
end if;
exception when others then null;
end;

select last_name from employees where employee_id=175;


declare
v_clob clob:='abababababa';
begin
test_warn_proc(v_clob);
end;

/



select * from user_dependencies
where referenced_name='EMPLOYEES';

create or replace procedure p1 
is
v_clob clob :='asdasdas';
begin
test_warn_proc(v_clob);
end;
/

create or replace procedure p2
is
begin 
p1;
end;
/


select lpad(name,length(name)+level*10,' ') from user_dependencies 
connect by nocycle prior name=referenced_name 
start with referenced_name='EMPLOYEES';

select * from user_objects;

alter table employees modify last_name varchar2(80);


begin
p1;
end;
/














-- LABS 

1) Create a function to get last_name info given employee_id.
    create or replace function get_lname(p_emp_id number)
     return varchar2
     is
     v_lname varchar2(50);
     begin
     select last_name 
     into v_lname
     from employees where employee_id=p_emp_id;
     return v_lname;
     exception when no_data_found then return 'Böyle bir çal??an bulunamad?';
     end;
     /
     
     select get_lname(77) from dual;
     
  
  
2) Create a procedure insert a new department to departments table.

  create or replace procedure add_dept(p_dept_id number,p_dept_name varchar2,
                                       p_man_id number,p_loc_id number)
  is
  
  begin
  insert into departments values (p_dept_id,p_dept_name,p_man_id,p_loc_id);
  commit;
  end;
/

  create or replace procedure add_dept(p_dept_name varchar2,
                                       p_man_id number,p_loc_id number)
  is
  
  begin
  insert into departments values (departments_seq.nextval,p_dept_name,p_man_id,p_loc_id);
  commit;
  end;


3) Create a procedure printing last hired 2 employee for giving department.

  create or replace procedure print_top2 (p_dept_id number)
  is
  cursor emp_cur is select * from employees where department_id=p_dept_id and rownum<=2
                    order by hire_date desc;
  begin
    for i in emp_cur loop
      yaz(i.last_name);
    end loop;
  end;
/ 

begin
  print_top2(10);
end;


4) Create a trigger to cancel insert or update on departments table at weekend. 

select to_char(sysdate,'DAY') from dual;


create or replace trigger cancel_dml 
before update or insert  on departments 
begin
if to_char(sysdate,'DAY') in ('SUNDAY','SATURDAY') then 
  raise_application_error(-20005,'Haftasonu i?lem yap?lamaz');
end if;
end;
/



5) create a package and add the first 3 subprogram 

create or replace package lab_pkg 
is
function get_lname(p_emp_id number) return varchar2;
 procedure add_dept(p_dept_id number,p_dept_name varchar2,
                                       p_man_id number,p_loc_id number);
  procedure print_top2 (p_dept_id number);                                     
end;
/
create or replace package body lab_pkg 
is

function get_lname(p_emp_id number)
     return varchar2
     is
     v_lname varchar2(50);
     begin
     select last_name 
     into v_lname
     from employees where employee_id=p_emp_id;
     return v_lname;
     exception when no_data_found then return 'Böyle bir çal??an bulunamad?';
     end;

 procedure add_dept(p_dept_id number,p_dept_name varchar2,
                                       p_man_id number,p_loc_id number)
  is
  
  begin
  insert into departments values (p_dept_id,p_dept_name,p_man_id,p_loc_id);
  commit;
  end;
  procedure print_top2 (p_dept_id number)
  is
  cursor emp_cur is select * from employees where department_id=p_dept_id and rownum<=2
                    order by hire_date desc;
  begin
    for i in emp_cur loop
      yaz(i.last_name);
    end loop;
  end;
end;
/

6) Create a procedure select for any table and any column but just first value. 
create or replace procedure dyn_proc(p_tname varchar2,p_col varchar2)
is
v_data varchar2(500);
begin
execute immediate 'select '||p_col||' from '||p_tname||' where rownum=1' into v_data;
  yaz(v_data);
end;
/

begin
dyn_proc('emp','salary');
end;



7) Create a table that has 4 columns(id,user,action,date) 
   and create a logon trigger for database to insert info into that table.
create table login_log_tbl (id number , uname varchar2(50),action varchar2(50),login_date date);
create sequence log_seq;

create or replace trigger hr.logon_trig 
after logon on database 
begin
  insert into hr.login_log_tbl values (log_seq.nextval,user,'Logon',sysdate);
end;





select * from login_log_tbl;


select user from dual;


select sys_context('userenv','module') from dual;




