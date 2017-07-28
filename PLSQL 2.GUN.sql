begin
update employees set salary=salary+1
where employee_id=744;
yaz(sql%rowcount||' row(s) updated');
if sql%notfound  then 
  raise no_data_found;
end if;
end;
/*
IMP
sql%rowcount => cursor?n gösterdip?i yada i?leme alaca?? sat?r say?s?(Numeric)
sql%notfound => Cursor herhangi bir sat?r? i?aret ediyor mu?
sql%found    => Cursor herhangi bir sat?r? i?aret ediyor mu?
*/


select * from employees 
where employee_id is not null;
/
declare
v_emp_id number :=100;
v_dept_id number;
v_salary  employees.salary%type;
v_output varchar2(5000);
begin
select department_id,salary 
  into v_dept_id,v_salary 
from employees where employee_id=v_emp_id;

v_output:=case v_dept_id 
            when 10 then 'Sizin de i?iniz zor'
            when 50 then 'Bu paraya bu i? yap?lmaz'
            when 90 then 'Dünya size güzel'
            else 'Yorum Yok'
          end;
yaz(v_output);
end;
/

declare
v_emp_id number :=100;
v_dept_id number;
v_salary  employees.salary%type;
v_output varchar2(5000);
begin
select department_id,salary 
  into v_dept_id,v_salary 
from employees where employee_id=v_emp_id;

v_output:=case 
            when v_dept_id is null then 'Gez gez aylak aylak'
            when v_dept_id in  (10,20) then 'Sizin de i?iniz zor'
            when v_dept_id between 50 and 90  then 'Bu paraya bu i? yap?lmaz'
            when v_dept_id <> 90 then 'Dünya size güzel'
            else 'Yorum Yok'
          end;
yaz(v_output);
end;
/



declare
v_emp_id number :=100;
v_dept_id number;
v_salary  employees.salary%type;
v_output varchar2(5000);
begin
select department_id,salary 
  into v_dept_id,v_salary 
from employees where employee_id=v_emp_id;

case 
     when v_dept_id is null then 
      yaz('Departman güncellemesi gerçekle?tiriliyor');
       update employees set department_id=10 where employee_id=100;
     when v_dept_id in  (10,20) then yaz('Sizin de i?iniz zor');
     when v_dept_id between 50 and 90  then yaz('Bu paraya bu i? yap?lmaz');
     when v_dept_id <> 90 then yaz('Dünya size güzel');
     else yaz('Yorum Yok');
end case;

end;
/



LOOPS 

BASIC LOOP 
/
declare
counter number:=0;
begin
  loop
      counter:=counter+1;
    exit when counter>10;
    yaz(counter|| '  DENEME');
  end loop;
end;
/


--WHILE LOOP 

declare
counter number:=1;
begin
  while counter<=10 loop
      
    yaz(counter|| '  DENEME');
    counter:=counter+1;
  end loop;
end;
/


FOR LOOP 





begin
  for i in reverse 1..10   loop
    yaz(i|| '  DENEME');
  end loop;
end;
/






declare
v_bool boolean:=NULL;
begin
  if not v_bool then 
    yaz('TRUE');
  else 
    yaz('FALSE');
  end if;
end;
/


select  * from employees where department_id is null;
select  * from employees where department_id is not null;



/
declare

begin
<<armut>>
for i in 1..10 loop
  for j in 1..10 loop
    exit armut when i*j=10;
    yaz('i:'||i ||' j:'||j); 
    yaz(i*j);
  end loop;
  yaz('-------------------------------');
end loop armut;
  yaz('================================');
end;
/

declare

begin
<<armut>>
for i in 1..10 loop
  for j in 1..10 loop
    continue  when i*j=10;
    yaz('i:'||i ||' j:'||j); 
    yaz(i*j);
  end loop;
  yaz('-------------------------------');
end loop armut;
  yaz('================================');
end;
/

declare

begin
<<armut>>
for i in 1..10 loop
  for j in 1..10 loop
    continue armut when i*j=10;
    yaz('i:'||i ||' j:'||j); 
    yaz(i*j);
  end loop;
  yaz('-------------------------------');
end loop armut;
  yaz('================================');
end;
/
---------------------------------------------------
COMPOSITE DATA TYPES  

RECORDS 

declare
v_lname varchar2(50);
v_sal number;
v_hdate date;
v_dept_id number;
begin
select last_name,salary,hire_date,department_id
into v_lname,v_sal,v_hdate,v_dept_id
from employees
where employee_id=100;
yaz(v_lname);
yaz(v_sal);
yaz(v_hdate);
yaz(v_dept_id);
end;

/


declare
type my_rec is record(
                      v_lname varchar2(50),
                      v_sal number,
                      v_hdate date,
                      v_dept_id number);
v_myrec  my_rec;
begin
select last_name,salary,hire_date,department_id
into v_myrec 
from employees
where employee_id=100;
yaz(v_myrec.v_lname);
yaz(v_myrec.v_sal);
yaz(v_myrec.v_hdate);
yaz(v_myrec.v_dept_id);
end;
/



declare
v_myrec  employees%rowtype;
begin
select *
into v_myrec 
from employees
where employee_id=100;
yaz(v_myrec.salary);
yaz(v_myrec);
end;
/


COLLECTIONS 

Associative arrays 

declare 
type lname_arr is table of varchar2(50)--array desc
   index by pls_integer;
v_lname lname_arr;
begin
for i in 100..206 loop
  select last_name 
  into v_lname(i)
  from employees
  where employee_id=i;
end loop;
for j in v_lname.first..v_lname.last loop
yaz(v_lname(j));
end loop;
yaz(v_lname(137));
yaz(v_lname(141));
end;
/

declare 
v_lname varchar2(50);
begin
for i in 100..206 loop
  select last_name 
  into v_lname
  from employees
  where employee_id=i;
  yaz(v_lname);
end loop;
select last_name into v_lname from employees 
where employee_id=103;
yaz(v_lname);
select last_name into v_lname from employees 
where employee_id=141;
yaz(v_lname);
end;
/


Nested Table Array 
Unbounded 
indexler s?ral? olmak zorundalar ve daima 1 den ba?larlar 
Manuel Extend 

declare
type sal_arr is table of employees.salary%type;
v_sal sal_arr;
begin
select salary bulk collect into v_sal from employees 
order by salary desc;
v_sal.extend;
v_sal(108):=1111;
yaz(v_sal(108));
end;
/

Varray 

Bounded 
indexler s?ral? olmak zorundalar ve daima 1 den ba?larlar 
NO Extend 

declare 
type fname_arr is varray(108) of varchar2(50);
v_fname fname_arr;
begin
select first_name bulk collect into v_fname from employees;
v_fname.extend;
yaz(v_fname(108));
end;











declare
type emp_arr is table of employees%rowtype
index by pls_integer;
v_emps emp_arr;
begin 
for i in 100..206 loop
  select * into v_emps(i) 
  from employees where employee_id=i;
end loop;

yaz(v_emps(103).last_name);
yaz(v_emps(203).salary);
end;

-------------------------------------------------------------------

CURSORS   

Declare - Open - Fetch - Empty ? - Close 


declare 
cursor myemp_cur is select last_name 
                from employees 
                where department_id=50;
v_lname varchar2(50);                
begin
open myemp_cur;
for i in 1..1500 loop
  fetch myemp_cur into v_lname;
  exit when  myemp_cur%notfound;
  yaz(v_lname);
end loop;
close myemp_cur;
end;
/

sql%notfound sql%found sql%rowcount (Implicit Cursor)
cursor_name%notfound 
cursor_name%found 
cursor_name%rowcount
cursor_name%isopen (Explicit Cursor)







declare 
cursor myemp_cur is select last_name 
                from employees 
                where department_id=50;
begin
for i in myemp_cur loop
  yaz(i.last_name);
end loop;
end;
/



?? Her departmandaki en y?ksek maa? alan ilk 3 ki?inin 
soyad? ad? maa?? ve departman bilgileri rapor olarak al?nacak

declare
cursor dept_cur is select * from departments;
cursor emp_cur(p_dept_id number) is select * from employees 
                                    where department_id=p_dept_id
                                    order by salary desc;

begin
yaz('********  DEPT REPORT *********');
for i in dept_cur loop
    YAZ(''); 
    yaz('Department_Name :'||i.department_name);
    yaz('TOP 3 WORKERS :');
    yaz('--------------------');
    for j in emp_cur(i.department_id)  loop
        exit when emp_cur%rowcount>3;
        yaz('Last Name :'||j.last_name||' Salary :'||j.salary );     
    end loop;
end loop;
end;
/





declare
cursor emp_cur is select last_name,salary from employees for update;
begin
  for i in emp_cur loop
      update employees set salary=salary+500 where current of emp_cur;
  end loop;
end;

























