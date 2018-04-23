select 'drop table '||table_name||' cascade constraints;' from user_tables;

select * from user_tables;

desc countries;
Describe countries;
select * from countries;

alter session set nls_date_format = 'DD/MM/YYYY'

select sysdate from dual;

create table countries_2 as (select * from countries;
select * from countries_2;

create table countries_3 as (select * from countries where 1=0);

select * from countries;

desc countries; --- tablo kolanları hakkında bilgi verir.

alter table countries drop column country_name;

alter table countries set unused  column region_id;

rename countries_3 to countries_4;

rename countries_2 to countries; ---tablo adı degistirme


create table deneme (ad varchar2(10),soyad varchar2(30));

drop  table deneme;

select * from recyclebin  t;---silinen tablolar.

flashback table deneme to before drop; ----siline(drop) edilen tabloyu geri getirir.

select * from deneme;

insert into deneme(ad, soyad) values('sed', 'calis')
commit;

begin
for cur_temp in (select first_name, last_name from EMPLOYEES  ) loop
insert into deneme(ad, soyad) values(cur_temp.first_name, cur_temp.last_name)
commit;
end loop;
end;


