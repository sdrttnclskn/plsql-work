---- Oracle Dersleri 2-------
select * from employees;

create table calisan as (select * from employees);

select * from calisan;

desc calisan;

drop table calisan;

select * from recyclebin;

flashback table calisan to before drop;

alter table calisan 
add constraint salary_min check (salary > 1500);---kısıt kontrol.

INSERT INTO calısan (
    employee_ıd,
    fırst_name,
    last_name,
    emaıl,
    phone_number,
    hıre_date,
    job_ıd,
    salary,
    commıssıon_pct,
    manager_ıd,
    department_ıd
) VALUES (
    207 ,
    'Steven', 
    'King',
    'SKING',
    '515.123.4567', 
    '17/06/1987', 
    'AD_PRES', 
    1700,
    null,
    null,  
    90);
    
    ------
select * from USER_CONSTRAINTS  where table_name= 'CALISAN';

alter table calisan drop constraint salary_min; ----kısıtın silinmesi

select * from calisan;

alter table calisan add ( toplam_id as (manager_id + department_id)); ---sanal kolun

create table calisan_ek as (select employee_id as id , first_name as adi, salary as maas from calisan where 1= 2);

insert into  calisan_ek (id, adi, maas)
select employee_id , first_name, salary from calisan;

update calisan_ek set adi = '&adi' where maas = '&maas'; ---- dısardan data alır.








