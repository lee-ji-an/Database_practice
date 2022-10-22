
--#6-1: Aggregates
--1)
select Dname, count(*)
from department, employee
where salary >= 20000
and dno = dnumber
and dno in (select dno
                from employee
                having avg(salary) >= 20000
                group by dno)
group by dname
order by count(*) desc;

/*
DNAME             COUNT(*)
--------------- ----------
Research                 4
Administration           3
Headquarters             1
*/

--2)
select dno, dname, count(*)
from department, employee
where salary > 20000
and sex = 'F'
and dno = dnumber
group by dno, dname
order by dno;

/*
       DNO DNAME             COUNT(*)
---------- --------------- ----------
         4 Administration           2
         5 Research                 1
*/


--#6-2: NOT EXISTS

--1)
select fname, lname, salary
from employee
where not exists ((select pnumber
                    from project
                    where dnum = 1)
                    minus
                    (select pno
                    from works_on
                    where ssn = essn))
order by salary desc;
/*
FNAME           LNAME               SALARY
--------------- --------------- ----------
James           Borg                 55000
Jennifer        Wallace              43000
Franklin        Wong                 40000
*/

--2)
select dno, dname, fname, lname
from employee, department
where mgr_ssn = ssn
and not exists (select *
                from dependent
                where ssn = essn);
/*
       DNO DNAME           FNAME           LNAME          
---------- --------------- --------------- ---------------
         1 Headquarters    James           Borg           
*/


--#6-3: Nested Queries
--1)
select e.fname, e.lname
from employee e
where e.dno in (select s.dno
                from employee s
                where s.salary in (select max(d.salary)
                                from employee d));
/*
FNAME           LNAME          
--------------- ---------------
James           Borg           
*/

--2)
select fname, lname
from employee
where super_ssn in (select s.ssn       
                from employee s
                where s.super_ssn = '888665555');

/*
FNAME           LNAME          
--------------- ---------------
John            Smith          
Alicia          Zelaya         
Ramesh          Narayan        
Joyce           English        
Ahmad           Jabbar         
*/

--3)
select fname, lname
from employee
where salary >= (select min(salary)+5000
                from employee);
/*
FNAME           LNAME          
--------------- ---------------
John            Smith          
Franklin        Wong           
Jennifer        Wallace        
Ramesh          Narayan        
James           Borg           
*/

--#6-4: View
--1)
create view dept_summary (d, c, total_s, avg_s) as
select dno, count(*), sum(salary), round(avg(salary), 1)
from employee
group by dno;

/*
         D          C    TOTAL_S      AVG_S
---------- ---------- ---------- ----------
         1          1      55000      55000
         5          4     133000      33250
         4          3      93000      31000

*/

--2)
select *
from dept_summary where d = 4;

/*
         D          C    TOTAL_S      AVG_S
---------- ---------- ---------- ----------
         4          3      93000      31000
*/

--3)
select d, c
from dept_summary
where total_s between 50000 and 100000;

/*
         D          C
---------- ----------
         1          1
         4          3
*/

--4)
select d, avg_s
from dept_summary
where c > (select c from dept_summary where d = 1)
order by avg_s desc;

/*
         D      AVG_S
---------- ----------
         5      33250
         4      31000
*/

--5)
update dept_summary
set d = 3
where d = 1;

/*
오류 보고 -
SQL 오류: ORA-01732: data manipulation operation not legal on this view
01732. 00000 -  "data manipulation operation not legal on this view"
*Cause:    
*Action:
*/

--6)
delete from dept_summary
where c >= 1;
/*
오류 보고 -
SQL 오류: ORA-01732: data manipulation operation not legal on this view
01732. 00000 -  "data manipulation operation not legal on this view"
*Cause:    
*Action:
*/

--#6-5
create or replace trigger salary_violation
before insert or update of salary on employee
referencing new as new
for each row
    begin
        if (:new.salary > 80000) then
            if inserting then
                    dbms_output.put_line('New salary: '||:new.salary);
                end if;
            if updating then
                    dbms_output.put_line('Old salary: '||:old.salary);
                    dbms_output.put_line('[ALERT] New salary: '||:new.salary);
                    dbms_output.put_line('Salary difference: '||(:new.salary-:old.salary));
                end if;
        end if;
    end;
/


set serveroutput on;

ALTER trigger salary_violation enable;

update employee
set salary = salary * 2
where ssn = '888665555';
/*
Old salary: 55000
[ALERT] New salary: 110000
Salary difference: 55000


1 행 이(가) 업데이트되었습니다.
*/

rollback;