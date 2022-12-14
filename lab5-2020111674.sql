
DROP TABLE DEPARTMENT CASCADE CONSTRAINT;
DROP TABLE EMPLOYEE CASCADE CONSTRAINT;
DROP TABLE DEPT_LOCATIONS CASCADE CONSTRAINT;
DROP TABLE PROJECT CASCADE CONSTRAINT;
DROP TABLE WORKS_ON CASCADE CONSTRAINT;
DROP TABLE DEPENDENT CASCADE CONSTRAINT; 

CREATE TABLE EMPLOYEE(
	Fname		VARCHAR(15)	    NOT NULL,
	Minit		CHAR,
	Lname		VARCHAR(15)    NOT NULL,
	Ssn		    CHAR(9)		    NOT NULL,
	Bdate		DATE,
	Address		VARCHAR(30),
	Sex		    CHAR,
	Salary		NUMBER(10, 2),
	Super_ssn	CHAR(9),
	Dno 		NUMBER	    DEFAULT 1 NOT NULL,
	PRIMARY KEY (Ssn)
);


CREATE TABLE DEPARTMENT(
	Dname		    VARCHAR(15)	    NOT NULL,
	Dnumber		    NUMBER		    NOT NULL,
	Mgr_ssn		    CHAR(9)     	DEFAULT	'888665555'	NOT NULL,
	Mgr_start_date	DATE,
    PRIMARY KEY (Dnumber),
	UNIQUE	(Dname)
);

CREATE TABLE DEPT_LOCATIONS(
    Dnumber         NUMBER          NOT NULL,
    Dlocation       VARCHAR(15)     NOT NULL,
    PRIMARY KEY(Dnumber, Dlocation)
);

CREATE TABLE PROJECT(
    Pname           VARCHAR(15)     NOT NULL,
    Pnumber         NUMBER          NOT NULL,
    Plocation       VARCHAR(15),
    Dnum            NUMBER          ,--NOT NULL,
    PRIMARY KEY(Pnumber),
    UNIQUE(Pname)
);

CREATE TABLE WORKS_ON(
    Essn            CHAR(9)         NOT NULL,
    Pno             NUMBER          NOT NULL,
    Hours           NUMBER(3, 1),
    PRIMARY KEY(Essn, Pno)
);

CREATE TABLE DEPENDENT(
    Essn            CHAR(9)             NOT NULL,
    Dependent_name  VARCHAR(15)         NOT NULL,
    Sex             CHAR,
    Bdate           DATE,
    Relationship    VARCHAR(8),
    PRIMARY KEY(Essn, Dependent_name)
);




--insert
INSERT INTO DEPARTMENT VALUES ('Research', 5, '333445555', TO_DATE('1988-05-22', 'yyyy-mm-dd'));
INSERT INTO DEPARTMENT VALUES ('Administration', 4, '987654321', TO_DATE('1995-01-01', 'yyyy-mm-dd'));
INSERT INTO DEPARTMENT VALUES ('Headquarters', 1, '888665555', TO_DATE('1981-06-19', 'yyyy-mm-dd'));

INSERT INTO EMPLOYEE VALUES ('John', 'B', 'Smith', '123456789', TO_DATE('1955-01-09', 'yyyy-mm-dd'), '731 Fondren, Houston, TX', 'M', 30000, 333445555, 5);
INSERT INTO EMPLOYEE VALUES ('Franklin', 'T', 'Wong', '333445555', TO_DATE('1968-01-19', 'yyyy-mm-dd'), '638 Voss, Houston, TX', 'M', 40000, '888665555', 5);
INSERT INTO EMPLOYEE VALUES ('Alicia', 'J', 'Zelaya', '999887777', TO_DATE('1968-01-19', 'yyyy-mm-dd'), '291 Berry, Bellaire, TX', 'F', 43000, '888665555', 4);
INSERT INTO EMPLOYEE VALUES ('Jennifer', 'S', 'Wallace', '987654321', TO_DATE('1941-06-20', 'yyyy-mm-dd'), '291 Berry, Bellaire, TX', 'F', 43000, '888665555', 4);
INSERT INTO EMPLOYEE VALUES ('Ramesh', 'K', 'Narayan', '666884444', TO_DATE('1962-09-15', 'yyyy-mm-dd'), '975 Fire Oak, Humble, TX', 'M', 38000, '333445555', 5);
INSERT INTO EMPLOYEE VALUES ('Joyce', 'A', 'English', '453453453', TO_DATE('1972-07-31', 'yyyy-mm-dd'), '5631 Rice, Houston, TX', 'F', 25000, '333445555', 5);
INSERT INTO EMPLOYEE VALUES ('Ahmad', 'V', 'Jabbar', '987987987', TO_DATE('1969-03-29', 'yyyy-mm-dd'), '980 Dallas , Houston, TX', 'M', 25000, '987654321', 4);
INSERT INTO EMPLOYEE VALUES ('James', 'E', 'Borg', '888665555', TO_DATE('1937-11-10', 'yyyy-mm-dd'), '', 'M', 55000, NULL, 1);

INSERT INTO DEPT_LOCATIONS VALUES (1, 'Houston');
INSERT INTO DEPT_LOCATIONS VALUES (4, 'Stafford');
INSERT INTO DEPT_LOCATIONS VALUES (5, 'Bellaire');
INSERT INTO DEPT_LOCATIONS VALUES (5, 'Sugarland');
INSERT INTO DEPT_LOCATIONS VALUES (5, 'Housston');

INSERT INTO PROJECT VALUES ('ProductX', 1, 'Bellaire', 5);
INSERT INTO PROJECT VALUES ('ProductY', 2, 'Sugarland', 5);
INSERT INTO PROJECT VALUES ('ProductZ', 3, 'Houston', 5);
INSERT INTO PROJECT VALUES ('Computerization', 10, 'Stafford', 4);
INSERT INTO PROJECT VALUES ('Reorganization', 20, 'Houston', 1);
INSERT INTO PROJECT VALUES ('Newbenefits', 30, 'Stafford', 4);

INSERT INTO WORKS_ON VALUES ('123456789', 1, 32.5);
INSERT INTO WORKS_ON VALUES ('123456789', 2, 7.5);
INSERT INTO WORKS_ON VALUES ('666884444', 3, 40.0);
INSERT INTO WORKS_ON VALUES ('453453453', 1, 20.0);
INSERT INTO WORKS_ON VALUES ('453453453', 2, 20.0);
INSERT INTO WORKS_ON VALUES ('333445555', 2, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 3, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 10, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 20, 10.0);
INSERT INTO WORKS_ON VALUES ('999887777', 30, 30.0);
INSERT INTO WORKS_ON VALUES ('999887777', 10, 10.0);
INSERT INTO WORKS_ON VALUES ('987654321', 30, 20.0);
INSERT INTO WORKS_ON VALUES ('987654321', 20, 15.0);
INSERT INTO WORKS_ON VALUES ('888665555', 20, NULL);

INSERT INTO DEPENDENT VALUES ('333445555', 'Alice', 'F', TO_DATE('1986-04-05', 'yyyy-mm-dd'), 'Daughter');
INSERT INTO DEPENDENT VALUES ('333445555', 'Theodore', 'M', TO_DATE('1983-10-25', 'yyyy-mm-dd'), 'Son');
INSERT INTO DEPENDENT VALUES ('333445555', 'Joy', 'F', TO_DATE('1958-05-03', 'yyyy-mm-dd'), 'Spouse');
INSERT INTO DEPENDENT VALUES ('987654321', 'Abner', 'M', TO_DATE('1942-02-28', 'yyyy-mm-dd'), 'Spouse');
INSERT INTO DEPENDENT VALUES ('123456789', 'Michael', 'M', TO_DATE('1988-01-04', 'yyyy-mm-dd'), 'Son');
INSERT INTO DEPENDENT VALUES ('123456789', 'Alice', 'F', TO_DATE('1988-12-30', 'yyyy-mm-dd'), 'Daughter');
INSERT INTO DEPENDENT VALUES ('123456789', 'Elizabeth', 'F', TO_DATE('1967-05-05', 'yyyy-mm-dd'), 'Spouse');

commit;

--alter table
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn)   ON DELETE SET NULL;
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber)   ON DELETE SET NULL;

ALTER TABLE DEPARTMENT ADD FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn)	ON DELETE SET NULL;

ALTER TABLE DEPT_LOCATIONS ADD FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber)     ON DELETE SET NULL; --

ALTER TABLE PROJECT ADD FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)     ON DELETE SET NULL;

ALTER TABLE WORKS_ON ADD FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)        ON DELETE SET NULL; 
ALTER TABLE WORKS_ON ADD FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber)        ON DELETE SET NULL;

ALTER TABLE DEPENDENT ADD FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)        ON DELETE SET NULL;

--Q1
select Fname, Lname
from employee, project
where Pname = 'ProductX'
and Dnum = Dno
and Salary <= 30000
and Dno = 5
order by Lname;
/* result
FNAME           LNAME          
--------------- ---------------
Joyce           English        
John            Smith  
*/

--Q2
select Dno, Dname, Ssn, Fname
from EMPLOYEE, DEPARTMENT
where Mgr_ssn = '987654321'
and Dnumber = Dno
and Address like '%TX%';
/* result
       DNO DNAME           SSN       FNAME          
---------- --------------- --------- ---------------
         4 Administration  999887777 Alicia         
         4 Administration  987654321 Jennifer       
         4 Administration  987987987 Ahmad     
*/

--Q3
select Lname, Pname, Hours 
from WORKS_ON, PROJECT, EMPLOYEE
where Pname = 'Reorganization'
and Pnumber = Pno
and Hours >= 1
and Essn = Ssn
order by Hours desc;
/* result
LNAME           PNAME                HOURS
--------------- --------------- ----------
Wallace         Reorganization          15
Wong            Reorganization          10
*/

--Q4
select distinct Fname, Lname, Hours
from EMPLOYEE, WORKS_ON, PROJECT
where Pname like 'Product%'
and Pnumber = Pno
and Hours >= 10
and Essn = Ssn
order by Hours;

/* result
FNAME           LNAME                HOURS
--------------- --------------- ----------
Franklin        Wong                    10
Joyce           English                 20
John            Smith                 32.5
Ramesh          Narayan                 40
*/

--Q5
select Lname, Fname, D.Sex, D.Dependent_name, Relationship
from DEPENDENT D, EMPLOYEE
where Super_ssn = '333445555'
and Ssn = D.Essn;
/* result
LNAME           FNAME           S DEPENDENT_NAME  RELATION
--------------- --------------- - --------------- --------
Smith           John            M Michael         Son     
Smith           John            F Alice           Daughter
Smith           John            F Elizabeth       Spouse  
*/

--D1
delete from DEPENDENT
where Essn = '123456789'
and Relationship = 'Spouse';
-- 1 ??? ???(???) ?????????????????????.

rollback;

--D2
delete from DEPARTMENT
where Dnumber = 5;

/* result
delete from DEPARTMENT
where Dnumber = 5
?????? ?????? -
ORA-01407: cannot update ("COMPANY"."DEPT_LOCATIONS"."DNUMBER") to NULL
*/

rollback;

--D3
delete from WORKS_ON
where Pno = 30
and Hours >= 50;
-- 0??? ??? ???(???) ?????????????????????.

rollback;

--U1
update PROJECT
set Plocation = 'Daegu'
where Dnum = 4;

select * from PROJECT where Dnum = 4;
/* result
PNAME              PNUMBER PLOCATION             DNUM
--------------- ---------- --------------- ----------
Computerization         10 Daegu                    4
Newbenefits             30 Daegu                    4
*/
rollback;

--U3
update EMPLOYEE
set Address = '80 Daehakro Daegu'
where Dno = 5;

select * from EMPLOYEE where Dno = 5;
/* result
FNAME           M LNAME           SSN       BDATE    ADDRESS                        S     SALARY SUPER_SSN        DNO
--------------- - --------------- --------- -------- ------------------------------ - ---------- --------- ----------
John            B Smith           123456789 55/01/09 80 Daehakro Daegu              M      30000 333445555          5
Franklin        T Wong            333445555 68/01/19 80 Daehakro Daegu              M      40000 888665555          5
Ramesh          K Narayan         666884444 62/09/15 80 Daehakro Daegu              M      38000 333445555          5
Joyce           A English         453453453 72/07/31 80 Daehakro Daegu              F      25000 333445555          5
*/

rollback;