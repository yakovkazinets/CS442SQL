create table branch(branch_id integer, branch_name varchar(20), branch_addr varchar(50), branch_city varchar(20), branch_phone integer);

Insert into YAKOV.BRANCH (BRANCH_ID,BRANCH_NAME,BRANCH_ADDR,BRANCH_CITY,BRANCH_PHONE) values (10,'Main','1234 Main St.','Hoboken',5551234);
Insert into YAKOV.BRANCH (BRANCH_ID,BRANCH_NAME,BRANCH_ADDR,BRANCH_CITY,BRANCH_PHONE) values (20,'NYC','23 No.3 Road','NYC',5552331);
Insert into YAKOV.BRANCH (BRANCH_ID,BRANCH_NAME,BRANCH_ADDR,BRANCH_CITY,BRANCH_PHONE) values (30,'West Creek','251 Creek Rd.','Newark',5552511);
Insert into YAKOV.BRANCH (BRANCH_ID,BRANCH_NAME,BRANCH_ADDR,BRANCH_CITY,BRANCH_PHONE) values (40,'Blenheim','1342 W.22 Ave.','Princeton',5551342);

create table driver(driver_ssn integer, driver_name varchar(20), driver_addr varchar(50), driver_city varchar(20), driver_birthdate date, driver_phone integer);

Insert into YAKOV.DRIVER (DRIVER_SSN,DRIVER_NAME,DRIVER_ADDR,DRIVER_CITY,DRIVER_BIRTHDATE,DRIVER_PHONE) values (11111111,'Bob Smith','111 E.11 St.','Hoboken',to_date('01-JAN-75','DD-MON-RR'),5551111);
Insert into YAKOV.DRIVER (DRIVER_SSN,DRIVER_NAME,DRIVER_ADDR,DRIVER_CITY,DRIVER_BIRTHDATE,DRIVER_PHONE) values (22222222,'John Walters','222 E.22 St.','Princeton',to_date('02-FEB-76','DD-MON-RR'),5552222);
Insert into YAKOV.DRIVER (DRIVER_SSN,DRIVER_NAME,DRIVER_ADDR,DRIVER_CITY,DRIVER_BIRTHDATE,DRIVER_PHONE) values (33333333,'Troy Rops','333 W.33 Ave','NYC',to_date('03-MAR-70','DD-MON-RR'),5553333);
Insert into YAKOV.DRIVER (DRIVER_SSN,DRIVER_NAME,DRIVER_ADDR,DRIVER_CITY,DRIVER_BIRTHDATE,DRIVER_PHONE) values (44444444,'Kevin Mark','444 E.4 Ave.','Hoboken',to_date('04-APR-74','DD-MON-RR'),5554444);

create table license(license_no integer, driver_ssn integer, license_type char, license_class integer, license_expiry date, issue_date date, branch_id integer);

Insert into YAKOV.LICENSE (LICENSE_NO,DRIVER_SSN,LICENSE_TYPE,LICENSE_CLASS,LICENSE_EXPIRY,ISSUE_DATE,BRANCH_ID) values (1,11111111,'D',5,to_date('24-MAY-22','DD-MON-RR'),to_date('25-MAY-17','DD-MON-RR'),20);
Insert into YAKOV.LICENSE (LICENSE_NO,DRIVER_SSN,LICENSE_TYPE,LICENSE_CLASS,LICENSE_EXPIRY,ISSUE_DATE,BRANCH_ID) values (2,22222222,'D',5,to_date('29-AUG-23','DD-MON-RR'),to_date('29-AUG-16','DD-MON-RR'),40);
Insert into YAKOV.LICENSE (LICENSE_NO,DRIVER_SSN,LICENSE_TYPE,LICENSE_CLASS,LICENSE_EXPIRY,ISSUE_DATE,BRANCH_ID) values (3,33333333,'L',5,to_date('27-DEC-22','DD-MON-RR'),to_date('27-JUN-17','DD-MON-RR'),20);
Insert into YAKOV.LICENSE (LICENSE_NO,DRIVER_SSN,LICENSE_TYPE,LICENSE_CLASS,LICENSE_EXPIRY,ISSUE_DATE,BRANCH_ID) values (4,44444444,'D',5,to_date('30-AUG-22','DD-MON-RR'),to_date('30-AUG-17','DD-MON-RR'),40);

create table exam(driver_ssn integer, branch_id integer, exam_date date, exam_type char, exam_score integer);

Insert into YAKOV.EXAM (DRIVER_SSN,BRANCH_ID,EXAM_DATE,EXAM_TYPE,EXAM_SCORE) values (11111111,20,to_date('25-MAY-17','DD-MON-RR'),'D',79);
Insert into YAKOV.EXAM (DRIVER_SSN,BRANCH_ID,EXAM_DATE,EXAM_TYPE,EXAM_SCORE) values (11111111,20,to_date('02-DEC-17','DD-MON-RR'),'L',67);
Insert into YAKOV.EXAM (DRIVER_SSN,BRANCH_ID,EXAM_DATE,EXAM_TYPE,EXAM_SCORE) values (22222222,30,to_date('06-MAY-16','DD-MON-RR'),'L',25);
Insert into YAKOV.EXAM (DRIVER_SSN,BRANCH_ID,EXAM_DATE,EXAM_TYPE,EXAM_SCORE) values (22222222,40,to_date('10-JUN-16','DD-MON-RR'),'L',51);
Insert into YAKOV.EXAM (DRIVER_SSN,BRANCH_ID,EXAM_DATE,EXAM_TYPE,EXAM_SCORE) values (22222222,40,to_date('29-AUG-16','DD-MON-RR'),'D',81);
Insert into YAKOV.EXAM (DRIVER_SSN,BRANCH_ID,EXAM_DATE,EXAM_TYPE,EXAM_SCORE) values (33333333,10,to_date('07-JUL-17','DD-MON-RR'),'L',45);
Insert into YAKOV.EXAM (DRIVER_SSN,BRANCH_ID,EXAM_DATE,EXAM_TYPE,EXAM_SCORE) values (33333333,20,to_date('27-JUN-17','DD-MON-RR'),'L',49);
Insert into YAKOV.EXAM (DRIVER_SSN,BRANCH_ID,EXAM_DATE,EXAM_TYPE,EXAM_SCORE) values (33333333,20,to_date('27-JUL-17','DD-MON-RR'),'L',61);
Insert into YAKOV.EXAM (DRIVER_SSN,BRANCH_ID,EXAM_DATE,EXAM_TYPE,EXAM_SCORE) values (44444444,10,to_date('27-JUL-17','DD-MON-RR'),'L',71);
Insert into YAKOV.EXAM (DRIVER_SSN,BRANCH_ID,EXAM_DATE,EXAM_TYPE,EXAM_SCORE) values (44444444,20,to_date('30-AUG-17','DD-MON-RR'),'L',65);
Insert into YAKOV.EXAM (DRIVER_SSN,BRANCH_ID,EXAM_DATE,EXAM_TYPE,EXAM_SCORE) values (44444444,40,to_date('01-SEP-17','DD-MON-RR'),'L',62);

-- Q1:  Find the name of the drivers who got the license from the branch “NYC”.
select d.driver_name
from driver d, license l, branch b
where d.driver_ssn = l.driver_ssn 
and l.branch_id = b.branch_id 
and b.branch_name ='NYC';

--Q2:  Find the name of the drivers whose driver license expire by 12/31/2022
select d.driver_name
from driver d, license l
where d.driver_ssn = l.driver_ssn 
and l.license_expiry <= to_date('31-DEC-2022','DD-MON-RRRR');

--Q3:  Find the name of the drivers who took at least 2 exams for the same driver license type at the same branch.
select d.driver_name
from driver d, exam e
where d.driver_ssn = e.driver_ssn
group by d.driver_name, e.exam_type, e.branch_id
having COUNT(*) >= 2;

--Q4:  Find the name of the drivers whose exam scores get consecutively lower when he/she took more exams.
select distinct driver_name
from 
(select d.driver_name, e.exam_date, e.exam_score, 
exam_score - LAG(e.exam_score, 1, -1) over (order by d.driver_name, e.exam_date) as prev_score,
LAG(d.driver_name, 1, 'NA') over (order by d.driver_name, e.exam_date) as prev_driver

from driver d, exam e
where d.driver_ssn = e.driver_ssn
and d.driver_ssn in (
    select e.driver_ssn
    from exam e
    group by e.driver_ssn
    having count(*) > 1 )
)
where driver_name = prev_driver and prev_score <0
MINUS 
select distinct driver_name
from 
(select d.driver_name, e.exam_date, e.exam_score, 
exam_score - LAG(e.exam_score, 1, -1) over (order by d.driver_name, e.exam_date) as prev_score,
LAG(d.driver_name, 1, 'NA') over (order by d.driver_name, e.exam_date) as prev_driver

from driver d, exam e
where d.driver_ssn = e.driver_ssn
and d.driver_ssn in (
    select e.driver_ssn
    from exam e
    group by e.driver_ssn
    having count(*) > 1 )
)
where driver_name = prev_driver and prev_score >=0