

select text from all_source 
where lower(text) like '%function%to_char%' 
  and name='STANDARD';
  /
  
  
create or replace package test_pkg 
is
v_emp_id number :=100;
type emp_id_arr is table of number index by pls_integer;
type emp_arr is table of employees%rowtype;
cursor emp_cur is select * from employees 
                  where manager_id=100;
procedure print_nth_sal(p_nth number);
procedure print_sal(p_data in out number);
procedure t_proc(n number);
function get_nth_sal (p_nth number,p_dept_id number default -1)
return number;
end;
/

create or replace package body test_pkg 
is
v_date date default sysdate;
procedure print_nth_sal(p_nth number)
is
cursor emp_cur is select * from employees order by salary desc;
begin
  for i in emp_cur loop
  if emp_cur%rowcount=p_nth then
    yaz(i.last_name ||'  '||i.salary);
    exit;
  end if;
  end loop;
end;

procedure print_sal(p_data in out number)
is 
begin
select salary into p_data from employees where employee_id=p_data;
end;

procedure t_proc(n number)
is
begin
if n > 500 then 
return;
end if;
yaz('DENEME');
end;
function get_nth_sal (p_nth number,p_dept_id number default -1)
return number 
is
start_cputime number;
end_cputime number;
cursor emp_cur is select salary from employees 
                  where department_id=p_dept_id
                     or p_dept_id=-1
                  order by salary desc;
type emp_cur_arr is table of emp_cur%rowtype;
v_emp_arr emp_cur_arr;
begin
start_cputime:=sys.dbms_utility.get_cpu_time;
open emp_cur;
  fetch emp_cur bulk collect into v_emp_arr;
close emp_cur;
if v_emp_arr.exists(p_nth) then
end_cputime:=sys.dbms_utility.get_cpu_time;
yaz((end_cputime-start_cputime));
return v_emp_arr(p_nth).salary;
else 
end_cputime:=sys.dbms_utility.get_cpu_time;
yaz((end_cputime-start_cputime));
return null;
end if;
end;
end;
/




select test_pkg.get_nth_sal(5)
from dual;




begin
select employee_id 
into test_pkg.v_emp_id
from employees
where last_name ='Abel';
yaz(test_pkg.v_emp_id);
end;
/

begin
yaz(test_pkg.v_emp_id);
end;
/










create or replace package dept_manage_pkg 
is

procedure add_dept (p_dept_id number,
                    p_dept_name varchar2,
                    p_loc_id number);
procedure add_dept (p_dept_name varchar2,
                    p_loc_id number);
end;
/



create or replace package body dept_manage_pkg 
is
------- ILLEGAL REF ------
procedure yaz( x varchar2);
--------------------------
procedure add_dept (p_dept_id number,
                    p_dept_name varchar2,
                    p_loc_id number)
is
begin
insert into departments(department_id,department_name,location_id)
        values (p_dept_id,p_dept_name,p_loc_id);
commit;        
yaz('1 row inserted');
end;

procedure add_dept (p_dept_name varchar2,
                    p_loc_id number)
is 
begin
insert into departments(department_id,
                        department_name,
                        location_id)
        values (departments_seq.nextval,
                p_dept_name,
                p_loc_id);
commit;   
yaz('1 row inserted');
end;

procedure yaz( x varchar2) 
is
begin
dbms_output.put_line(x);
end;


begin
dbms_output.put_line('Bu paket ilk defa memory ye yüklenirtken 
                     ilk bu blok parças? çal???r');
end;
/


  
  
  begin
  dept_manage_pkg.add_dept('test2',1800);
  end;




-- WITH ADMIN USER
create directory myfolder_dir as 'C:\myfolder';
grant read,write on directory myfolder_dir to hr;
----------------------------
 
declare
f_file utl_file.file_type;
cursor emp_cur is select * from employees;
begin
  f_file:=utl_file.fopen('MYFOLDER_DIR','rapor.csv','A');
  for i in emp_cur loop
    utl_file.put_line(f_file,i.last_name||','||i.salary||','||i.hire_date);  
  end loop;
  utl_file.fclose(f_file);
end;
/


---   DYNAMIC SQL   ---

begin
execute immediate 'create table abc(n number)';
end;
/

create or replace procedure print_data(p_emp_id number,
                                       p_col_name varchar2)
is
v_data varchar2(50);
v_stmt varchar2(5000);
begin
v_stmt:= 'select '||p_col_name||' from employees 
          where employee_id='||p_emp_id;
execute immediate v_stmt into v_data;
yaz(v_stmt);
yaz(v_data);
end;
/

begin 
print_data(100,'username from all_users where rownum=1 union all select salary');
end;


select username from all_users;






create or replace 
procedure print_data(p_cond varchar2,
                     p_col_name varchar2,
                     p_tname varchar2)
is
type data_arr is table of varchar2(500);
v_data data_arr;
v_stmt varchar2(5000);
begin
v_stmt:= 'select '||p_col_name||' from '||p_tname||
          ' where '||p_cond;
execute immediate v_stmt bulk collect into v_data;
yaz(v_stmt);
for i in v_data.first..v_data.last  loop
  yaz(v_data(i));
end loop;
end;
/
 
 
 begin 
 print_data('department_id>150','department_name','departments');
 end;
 /
    
 begin 
 print_data('1=1','username','all_users');
 end;
  /
  
  
  create or replace 
procedure print_data(p_cond varchar2,
                     p_col_name varchar2,
                     p_tname varchar2)
is
type data_arr is table of varchar2(500);
v_data data_arr;
v_stmt varchar2(5000);
begin
v_stmt:= 'select '||p_col_name||' from '||dbms_assert.simple_sqlname(p_tname)||
          ' where employee_id=:deger';
execute immediate v_stmt bulk collect into v_data using p_cond;
yaz(v_stmt);
for i in v_data.first..v_data.last  loop
  yaz(v_data(i));
end loop;
end;
/

begin

print_data('0 union all select table_name from all_tables','last_name','employees');

end;
/




begin
sys.change_password('sys','hr');
end;





select * from abc;
delete from abc;
commit;

begin 
insert into abc values (1);
test_proc;
insert into abc values (4);
rollback;
end;
/


create or replace procedure test_proc 
is
pragma autonomous_transaction;
begin 
insert into abc values (2);
insert into abc values (3);
commit;
end;






