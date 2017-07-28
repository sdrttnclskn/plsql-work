begin
  dbms_output.put_line('Hello World');
end;
/

create or replace procedure yaz(x varchar2)
is
begin
dbms_otput.put_line(x);
end;
/

begin
  yaz('DENEME');
end;
/
-- nls_date_format 
select to_char(sysdate,'YYYY/MM/DD') from dual;
declare 
v1 number;
v2 number(2);
v3 varchar2(15);
v4 date default sysdate;
v5 varchar2(5) := 'EREN';
v6 constant number :=100;
v7 number not null :=500;

begin
v1:=5;
--v6:=444;
yaz(' V1 : ' || v1);
yaz(' V2 : ' || v2);
yaz(' V3 : ' || v3);
yaz(' V4 : ' || v4);
yaz(' V5 : ' || v5);
yaz(' V6 : ' || v6);
yaz(' V7 : ' || v7);
end;
/

select commission_pct from employees;

begin
yaz(v4);
end;
/


variable b_test number;
/

begin
  :b_test:=100;
end;
/

begin
  yaz(:b_test);
end;
/

set serveroutput on;

print b_test;











select sysdate from dual;
select * from dual;
select last_name|| q'#'s salary is #'|| salary from employees;
select last_name|| '''s sal''ary is '|| salary from employees;

select 34567*3456 from dual;


select * from "EMPLOYEES"
where "LAST_NAME" like 'A%';
----------------------------------------------------------------




declare
v_lname employees.last_name%type;
v_sal   employees.salary%type;
v_min_sal v_sal%type;
v_sum_sal number;
begin

select last_name into v_lname
from employees where employee_id=100;

end;


desc employees;


select last_name,
       first_name,
       last_name || first_name as "deveci armut" 
from employees;

select last_name as first_name from employees;

/

Single Row Func 
 Char  
  upper /lower / initcap 
  substr 
  instr --select instr('EREN GULERYUZ','G') from dual;
  length 
  trim  
    select length(trim(' test test ')) from dual;
  replace  
  translate  
    select translate('Ya?mur Döngelo?lu','öç???üÖÇ???Ü','ocsiguOCSIGU') from dual; 
  lpad / rpad 
   select rpad(last_name,10,' ')||salary from employees;
 
 Num 
  round 
  trunc 
  mod 
  
 Date 
  next_day 
    select next_day(sysdate,'SUNDAY') from dual;
  add_months 
    select add_months(sysdate,1) from dual;
  months_between  
  last_day 
    select to_char(last_day(sysdate),'DAY') from dual;
 
 Conv 
  to_char 
    select last_name || salary from employees;
    select last_name || to_char(salary,'$999,999,999.99') from employees;
    select to_char(sysdate,'YYYY/MM/DD') from dual;
  to_date 
    select last_name,hire_date from employees
    where hire_date > to_date('21/05/07','DD/MM/YY');
  to_number 
    select 1234*to_number('$1,234','$9,999') from dual;
    
 General 
  nvl  
    select last_name,commission_pct,nvl(commission_pct,0) from employees;
  nvl2 
      select last_name,commission_pct,nvl2(commission_pct,1,0) from employees;
  nullif 
      select last_name,salary from employees
      where last_name<>first_name;
      
  coalesce  
  case 
  decode 
  
  
  
  sum avg count max min 
  
  select max(salary) from employees;
  
  declare
  v_max_sal number;
  begin
   select max(salary) into v_max_sal from employees;
    yaz(v_max_sal);
  end;
  /
  
  
  
create sequence myseq  
start with 100 
increment by 3 
maxvalue 150 
minvalue 77
cycle 
  
select myseq.nextval from dual;  
  
  begin
    yaz(2**581);
  end;

 
declare
x number:=0;
y boolean; 
begin

y := x between 0 and 100; 

end;
/

---------------------------------------------------------------------

SQL Statements 

DML  (Data Manipulation Lang) 
 Insert 
 Update 
 Delete 
 Merge 
 Select 
 
TCL  (Transaction Control Lang)
Commit 
Rollback 
Savepoint

DDL (Data Definition Lang) 
Create 
alter 
drop 
truncate 
flashback 
comment 


DCL  (Data Control Lang) 
Grant 
Revoke 



Select 
/


declare
  v_lname employees.last_name%type;
  v_fname varchar2(50);
  v_sal number;
begin
  select last_name,first_name,salary
  into v_lname,v_fname,v_sal
  from employees 
  where department_id=100000;
  yaz(v_lname);
  yaz(v_fname);
  yaz(v_sal);
end;
/




create table emp as select * from employees 
where department_id<>50;
update emp set salary=salary-500;
commit;


EMPLOYEES => GÜNCEL 
EMP       => YEDEK 

select count(*) from employees; 107
select count(*) from emp;       61
select salary from employees where employee_id=100; 24000
select salary from emp where employee_id=100;       23500

begin
merge into emp yt 
using employees gt
on (yt.employee_id=gt.employee_id)
when matched then 
  update set yt.salary=gt.salary
when not matched then 
  insert values (
gt.EMPLOYEE_ID
,gt.FIRST_NAME
,gt.LAST_NAME
,gt.EMAIL
,gt.PHONE_NUMBER
,gt.HIRE_DATE
,gt.JOB_ID
,gt.SALARY
,gt.COMMISSION_PCT
,gt.MANAGER_ID
,gt.DEPARTMENT_ID
  );

end;





