-- Display dept wise sum salary where dptno in 10,20 and sum(sal) >2000
select deptno , sum(sal) from emp where deptno in(10,20) group by deptno having sum(sal)>2000 order by deptno;
-- Display no of emplyoee join in each year. ie date wise
select count(*) from emp group by to_char(hiredate,'yyyy') ;

SELECT DISTINCT EmpName FROM Employees WHERE DOB BETWEEN ‘01/01/1960’ AND ‘31/12/1975’;

select distinct ename from emp where hiredate between  to_char(to_date('11/10/1960','YYYY'),'YYYY') AND
to_char(to_date('11/10/1975','YYYY'),'YYYY');

select to_date('ll/10/1999','mm') from dual;

------------

-- 00
select deptno,job,sum(sal) from emp group by (deptno,job);
select deptno,job,sum(sal) from emp group by rollup(deptno,job); -- sun(sal) dept wise and grand total sal
select distinct deptno,job from emp order by deptno;

-- Display Top 3 max salary earning emp -- inline view -> result of subquery act as table for another query.
select * from( select e.*, dense_rank() over(order by e.sal desc) r  from emp e) where r <=3;




-- Display only Last 5 record 
select * from ( select * from emp order by rowid desc) where rownum <=5

-- Display Alternate record 
select  decode(mod(rownum,2),1,e.empno,0) from emp e;
select * from emp3 where (rowid,0) in ( select rowid,mod(rownum,2) from emp3);

-- Second higesh salary for each dept.
with shs as ( select row_number() over ( partition by sal order by deptno desc) r, sal , deptno, ename from emp)
select * from shs where r=2

select to_char(to_date('142','j'),'jsp'),to_char(sysdate,'ddspth'),to_number('$1000.00','L9999.99')  from dual;

-- Display employe earing more than any cleck.

select * from emp where sal>any(select sal from emp where job='clerk'); -- min(sal of list clerk) -- ?	Multi row subqueries

select * from emp where sal>all(select sal from emp where job='clerk'); -- max(sal of list of clerk) 
select * from emp where sal > (select max(sal) from emp where job='clerk');

-- Display 7th , 8 th and 9th records from a table.

--In single row subquery, it will return one value.
-- Display employee earning min and max salary.
select * from emp where sal in (select min(sal) from emp union select max(sal) from emp); -- multi row subquery In such cases we should include operators like any, all, in or not in between the comparision operator and the subquery.

-- Display employee earning second max salary  -- null value in subquery give all result null
select * from emp where sal=(select max(sal) from emp where sal<(select max(sal) from emp)); -- nested sub query
select max(sal) from emp where sal not in ( select max(sal) from emp);

-- find Max Salary from each department and display deptName.
select max(sal),deptno from emp group by deptno;
select max(sal),dname from emp e right join dept d on e.deptno=d.deptno group by dname;


--- Display employee earining more than average salary in their dept
select * from emp e where sal>= ( select avg(sal) from emp where e.deptno=deptno) ; -- use self join as correlated query is expensive.
                                                                  --select * from emp e,e1 where e1.mgr=e.deptno and e1.sal>=e.sal
 -- Display duplicate record from table.
 select e.* from emp e where rowid > (select min(rowid) from emp where e.empno=empno) ;
   Select empno,ename,job, count(*) from emp3 group by  empno,ename,job  having count(*) >1 ; 
  -- Report as .. Scalar query ->subquery in select list.
  select (select count(*) from emp) from dual;
  
  select rowid,rownum,empno,ename,job from emp3 e where rowid < (select max(rowid) from emp3 where e.empno=empno);


  
--- Single Row subquery...
-- Display max salary earning emp in each dept.
  select * from emp x where x.sal = (select max(sal) from emp where deptno=x.deptno);

  select e.deptno,max(e.sal) from emp e group by e.deptno ;
  
  
-- Mutiple Row SubQuery...
  -- display empname earnig max and min sal.
  --select * from emp where sal in (select max(sal) , min(sal) from emp); -- give  errror too many values ex sal in(-,-) ie multi column;
  select * from emp where sal in (select max(sal) from emp union select min(sal) from emp);--  sal in(-,
                                                                                            --  -)
-- MutiColumn query
  -- Display empname earning max sal in their dept;
  select * from emp where (deptno,sal) in (select deptno,max(sal) from emp group by deptno);
  Select to_char(trunc(sysdate),'dd-mon-yyyy hh:mi:ss am') from dual;
-- Nested query
  -- 
  
-- Correlated Query..

--A subquery is evaluated once for the entire parent statement 
--where as a correlated subquery is evaluated once for every row processed by the parent statement.
select distinct deptno from emp e where 5 <= (select count(ename) from emp where e.deptno = deptno);

-- inline view -- result of subquery act as a table for outter query.


--name’s second letter start with ‘a’.
select * from student where name like '_a%';

select initcap (ename) from emp ;
-- Functions can be categorized as follows.
--	Single row functions
-- Group functions ex. sum , avg,min, count,max

Create view empview as select *from emp; -- Simple view can be created from one table ;?	Hide the data complexity.
--as complex view can be created from multiple tables.

select * from empview;

insert into empview values (100,'kalok1','soft',7839,current_date, 5000,null,10);

Create view empview as select *from emp;

--How to display alternative rows in a table?

select *from emp where (rowid,0) in (select rowid,mod(rownum,2) from emp);

--Getting employee details of each department who is drawing maximum sal?

select *from emp where (deptno,sal) in   ( select deptno,max(sal)  from emp group by deptno);

Select deptno,count(*) from emp group by  deptno having count(*) >2500;


desc emp;

--- join
-- self join
-- display emp and their manager
select e1.ename,e2.ename from emp e1 , emp e2 where e1.mgr=e2.empno;

-- display employee name working under 'king'
select e1.ename,e2.ename from emp e1 , emp e2 where e1.mgr=e2.empno and e2.ename='king';



--Question 14: You have a composite index of three columns, and you only provide the
--value of two columns in WHERE clause of a select query? Will Index be used for this
--operation? For example if Index is on EmpId, EmpFirstName, and EmpSecondName and you
--write query like
--SELECT * FROM Employee WHERE EmpId=2 and EmpFirstName='Radhe'
--If the given two columns are secondary index column then the index will not invoke, but if the
--given 2 columns contain the primary index(first column while creating index) then the index will
--invoke. In this case, Index will be used because EmpId and EmpFirstName are primary columns.


