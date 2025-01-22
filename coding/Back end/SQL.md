


# Ask - need to review 
- dif bettwen delete and drop


SQL stands for Structured Query Language

# <span style="color:rgb(112, 48, 160)">Querys</span>
![[sql command.jpg]]
### <span style="color:rgb(0, 176, 240)">Data type in Databases</span>
![[sql data type.png]]
![[SQL Data type 1.png]]
![[SQL Data type3.png]]
![[SQL Data type4.png]]
![[SQL Data type2.png]]



### <span style="color:rgb(0, 176, 240)">Drop vs Delete</span>

| Feature           | DELETE                                                  | DROP                                                 |
| ----------------- | ------------------------------------------------------- | ---------------------------------------------------- |
| **Purpose**       | Remove rows from a table based on a condition           | Remove entire database objects (tables, views, etc.) |
| **Scope**         | Removes data, keeps table structure                     | Removes the entire structure and data                |
| **Syntax**        | `DELETE FROM table_name WHERE condition;`               | `DROP TABLE table_name;`                             |
| **Example**       | `DELETE FROM Employees WHERE EmployeeID = 1;`           | `DROP TABLE Employees;`                              |
| **Rollback**      | Can be rolled back if within a transaction              | Generally cannot be rolled back                      |
| **Triggers**      | Activates row-level triggers                            | Does not activate row-level triggers                 |
| **Performance**   | Slower for large data sets (removes rows one at a time) | Faster (removes structure and data in one operation) |
| **Data Recovery** | Data can be recovered if transaction is not committed   | Data and structure are lost unless there is a backup |

### <span style="color:rgb(0, 176, 240)">Switch Databases</span>
To switch to a different database, use the `USE` statement.
``` SQL
USE koko;
```

### <span style="color:rgb(0, 176, 240)">Drop Databases</span>

``` SQL
Drop DATABASE koko;
```

### <span style="color:rgb(0, 176, 240)">Delete vs Truncate statement.</span>

``` SQL
TRUNCATE TABLE Customers;
```

| Delete                                                          | truncate                                                     |
| --------------------------------------------------------------- | ------------------------------------------------------------ |
| whene delete table column and start again ID start from last ID | whene delete table column and start again ID start from 0 ID |
| if have 7 ID then delete then insert will strat from 8          | if have 7 ID then delete then insert will strat from 0       |
### <span style="color:rgb(0, 176, 240)">Creat table </span>

``` SQL
CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    column3 datatype,
   ....
);
```

### <span style="color:rgb(0, 176, 240)">Drop table</span>
``` SQL
DROP TABLE Employees;

```

### <span style="color:rgb(0, 176, 240)"> Add Column</span>
``` SQL
ALTER TABLE Employees
ADD Gendor char(1);

```

### <span style="color:rgb(0, 176, 240)">Rename Column</span>
``` SQL
exec sp_rename 'table_name.old_column_name', 'new_column_name', 'COLUMN';

```

### <span style="color:rgb(0, 176, 240)">Rename a table</span>
``` SQL
exec sp_rename 'old_table_name', 'new_table_name';

```

### <span style="color:rgb(0, 176, 240)">Modify a column(change the column's data type)</span>
``` SQL
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

```

### <span style="color:rgb(0, 176, 240)">Delete a column</span>
``` SQL
ALTER TABLE Employees
DROP COLUMN Gender;

```







### <span style="color:rgb(0, 176, 240)">BACKUP DATABASE</span>
``` SQL
BACKUP DATABASE MyDatabase1
TO DISK = 'C:\MyDatabase1_backup.bak';

```

### <span style="color:rgb(0, 176, 240)">Differential Backup</span>
A differential back up only backs up the parts of the database that have changed since the last full database backup.
``` SQL
BACKUP DATABASE MyDatabase1
TO DISK = 'C:\MyDatabase1_backup.bak'
WITH DIFFERENTIAL;

```

### <span style="color:rgb(0, 176, 240)">Restore Database</span>
``` SQL
RESTORE DATABASE MyDatabase1
FROM DISK = 'C:\MyDatabase1.bak';

```
### <span style="color:rgb(0, 176, 240)">Insert Into</span>
``` SQL
Insert Into Employees 
values
(2,'Emp2','552221',700),
(3,'Emp3','55554',300),
(4,'Emp4','322344',400);

```














### <span style="color:rgb(0, 176, 240)">Update Statement</span>
``` SQL
Update Employees 
set Name ='Mohammed Abu-Hadhoud' ,  Salary=5000
where ID=2

```


### <span style="color:rgb(0, 176, 240)">Select Into(copy table) </span>
``` SQL
SELECT *
INTO EmpoyeesCopy
FROM Employees;

```

### <span style="color:rgb(0, 176, 240)">Insert Into ..Select From Statement</span>
``` SQL

insert into OldPersons
select * from Persons 
where age >=30;`

```



### <span style="color:rgb(0, 176, 240)">Identity Field (Auto Increment)</span>
``` SQL
CREATE TABLE Persons (  
    Personid int IDENTITY(1,1) PRIMARY KEY,  
   LastName varchar(255) NOT NULL,  
   FirstName varchar(255),  
   Age int  
);

```

### <span style="color:rgb(0, 176, 240)">FOREIGN KEY-PRIMARY key</span>
``` SQL
CREATE TABLE Customers (
  id INT ,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  age INT,
  country VARCHAR(10),
  PRIMARY KEY (id)
);

CREATE TABLE Orders (
  order_id INT,
  item VARCHAR(40),
  amount INT,
  customer_id INT ,
  PRIMARY KEY (order_id)
);

-- Adding foreign key to the customer_id field using alter

ALTER TABLE Orders
ADD FOREIGN KEY (customer_id) REFERENCES Customers(id);

```


stop in SQL - Queries




























### <span style="color:rgb(0, 176, 240)">AND , OR, NOT</span>
``` SQL
Select * from Employees
where Not MonthlySalary<=500;



Select * from Employees
where MonthlySalary<500 and Gendor='F';


select * from Employees
where DepartmentID=1 Or DepartmentID=2;

```
### <span style="color:rgb(0, 176, 240)">"In" Operator</span>
``` SQL

select * from Employees where
DepartmentID=1 Or DepartmentID=2;

select * from Employees
where DepartmentID=1 Or DepartmentID=2 or DepartmentID=7;

select * from Employees 
where DepartmentID=1 Or DepartmentID=2 or DepartmentID=5 or DepartmentID=7;

select * from Employees 
where DepartmentID in (1,2,5,7);

select * from Employees 
where FirstName in ('Jacob','Brooks','Harper');

select Departments.Name from Departments
where ID in ( select DepartmentID from Employees where MonthlySalary <=210 ); 

select Departments.Name from Departments
where ID not in ( select DepartmentID from Employees where MonthlySalary <=210 );

```
### <span style="color:rgb(0, 176, 240)">Order By  / ASC -  DESC</span>
**Order By:**ASC
ASC: small to big
DESC: big to small

``` SQL
select ID, FirstName,MonthlySalary from Employees 
where DepartmentID=1 

select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1 Order By FirstName ;

select ID, FirstName,MonthlySalary from Employees where DepartmentID=1 Order By FirstName ASC; 

select ID, FirstName,MonthlySalary from Employees 
where DepartmentID=1 Order By FirstName desc;

select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1 Order By MonthlySalary ;

select ID, FirstName,MonthlySalary from Employees where DepartmentID=1 Order By MonthlySalary Asc; select ID, 

FirstName,MonthlySalary from Employees where
DepartmentID=1 Order By MonthlySalary Desc;

select ID, FirstName,MonthlySalary from Employees where DepartmentID=1 Order By FirstName , MonthlySalary ;

select ID, FirstName,MonthlySalary from Employees where DepartmentID=1 Order By FirstName ASC, MonthlySalary Desc;`

```

### <span style="color:rgb(0, 176, 240)">Select Top Statement</span>
``` SQL

Select * from Employees; 

-- This will show top 5 employees.
Select top 5 * from Employees;

-- This will show top 10% of the data.
select top 10 percent * from Employees;


-- this will show the all salaries ordered from the heighest to lowest.
select MonthlySalary from employees 
order by MonthlySalary Desc;


-- this will show the all salaries ordered from the heighest to lowest without redundancy.
select distinct MonthlySalary from employees
order by MonthlySalary Desc;


-- this will show the heighest 3 salaries. 
select distinct top 3 MonthlySalary from employees 
order by MonthlySalary Desc;


--This will show all employees who takes one of the heighest 3 salaries.
select ID , FirstName, MonthlySalary from Employees
where MonthlySalary In 
( select distinct top 3 MonthlySalary from employees
 order by MonthlySalary Desc ) 
 Order By MonthlySalary Desc 
 
 
 --This will show all employees who takes one of the Lowest 3 salaries. 
 select ID , FirstName, MonthlySalary from Employees where MonthlySalary In ( select distinct top 3 MonthlySalary from employees order by MonthlySalary ASC ) Order By MonthlySalary ASC`

```
### <span style="color:rgb(0, 176, 240)">Between Operator</span>
``` SQL
`Select * from Employees
where (MonthlySalary >=500 and MonthlySalary <=1000) 



Select * from Employees
where MonthlySalary Between 500 and 1000;`

```
### <span style="color:rgb(0, 176, 240)">Count, Sum, Avg, Min, Max Functions</span>
``` SQL
select 
TotalCount=Count(MonthlySalary),
TotalSum=Sum(MonthlySalary), 
Average=Avg(MonthlySalary), 
MinSalary=Min(MonthlySalary),
MaxSalary=Max(MonthlySalary) 
from Employees;

```
























### <span style="color:rgb(0, 176, 240)">Distinct (without repeated Value)</span>
```  sql
Select DepartmentID from Employees;
Select Distinct DepartmentID from Employees;

Select FirstName from Employees; 
Select Distinct FirstName from Employees;

Select FirstName, DepartmentID from Employees;
Select distinct FirstName, DepartmentID from Employees;

```
### <span style="color:rgb(0, 176, 240)">Group By</span>
the out put will be

| DepartmentID | Average | TotalSum | MinSalary | MaxSalary |
| ------------ | ------- | -------- | --------- | --------- |
| 1            | 111     | 223      | 4523      | 45        |
| 2            | 542     | 452      | 45        | 54        |
| 3            | 542     | 5243     | 524       | 542       |
| 4            | 5452    | 542      | 54        | 452       |
| 5            | 54      | 542      | 542       | 524       |

``` SQL
select TotalCount=Count(MonthlySalary), TotalSum=Sum(MonthlySalary), 
Average=Avg(MonthlySalary),
MinSalary=Min(MonthlySalary),
MaxSalary=Max(MonthlySalary) 
from Employees where DepartmentID=3 ;



select DepartmentID,
TotalCount=Count(MonthlySalary), 
TotalSum=Sum(MonthlySalary),
Average=Avg(MonthlySalary),
MinSalary=Min(MonthlySalary), 
MaxSalary=Max(MonthlySalary) 
from Employees
Group By DepartmentID
order by DepartmentI`

```
### <span style="color:rgb(0, 176, 240)">Having</span>

| Having                  | Where         |
| ----------------------- | ------------- |
| work only with Group by | work with all |

``` SQL
SELECT 
    DepartmentID, 
    TotalCount = COUNT(MonthlySalary), 
    TotalSum = SUM(MonthlySalary), 
    Average = AVG(MonthlySalary), 
    MinSalary = MIN(MonthlySalary), 
    MaxSalary = MAX(MonthlySalary) 
FROM 
    Employees 
GROUP BY 
    DepartmentID 
HAVING 
    COUNT(MonthlySalary) > 100;


```

<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)">note</span>  You can use where with Gruop by Using Subquery 

``` sql
SELECT * 
FROM (
    SELECT 
        DepartmentID, 
        TotalCount = COUNT(MonthlySalary), 
        TotalSum = SUM(MonthlySalary), 
        Average = AVG(MonthlySalary), 
        MinSalary = MIN(MonthlySalary), 
        MaxSalary = MAX(MonthlySalary) 
    FROM 
        Employees 
    GROUP BY 
        DepartmentID
) R1 
WHERE 
    R1.TotalCount > 100;

```



### <span style="color:rgb(0, 176, 240)">Like(Find text in value)</span>
A differential back up only backs up the parts of the database that have changed since the last full database backup.
``` SQL
-- Select all columns from Employees
SELECT * FROM Employees;

-- Finds any values that start with "a"
SELECT ID, FirstName 
FROM Employees
WHERE FirstName LIKE 'a%';

-- Finds any values that end with "a"
SELECT ID, FirstName 
FROM Employees
WHERE FirstName LIKE '%a';

-- Finds any values that have "tell" in any position
SELECT ID, FirstName 
FROM Employees
WHERE FirstName LIKE '%tell%';

-- Finds any values that start with "a" and end with "a"
SELECT ID, FirstName 
FROM Employees
WHERE FirstName LIKE 'a%a';

-- Finds any values that have "a" in the second position
SELECT ID, FirstName 
FROM Employees
WHERE FirstName LIKE '_a%';

-- Finds any values that have "a" in the third position
SELECT ID, FirstName 
FROM Employees
WHERE FirstName LIKE '__a%';

-- Finds any values that start with "a" and are at least 3 characters in length
SELECT ID, FirstName 
FROM Employees
WHERE FirstName LIKE 'a__%';

-- Finds any values that start with "a" and are at least 4 characters in length
SELECT ID, FirstName 
FROM Employees
WHERE FirstName LIKE 'a___%';

-- Finds any values that start with "a" or "b"
SELECT ID, FirstName 
FROM Employees
WHERE FirstName LIKE 'a%' 
   OR FirstName LIKE 'b%';


```

### <span style="color:rgb(0, 176, 240)">WildCards</span>
``` SQL
-- Update data for specific employees
UPDATE Employees 
SET FirstName = 'Mohammed', LastName = 'Abu-Hadhoud'
WHERE ID = 285;

UPDATE Employees 
SET FirstName = 'Mohammad', LastName = 'Maher'
WHERE ID = 286;

-------------------------------------

-- Select employees with first name 'Mohammed' or 'Mohammad'
SELECT ID, FirstName, LastName 
FROM Employees
WHERE FirstName = 'Mohammed' 
   OR FirstName = 'Mohammad';

-- Search for 'Mohammed' or 'Mohammad' using pattern matching
SELECT ID, FirstName, LastName 
FROM Employees
WHERE FirstName LIKE 'Mohamm[ae]d';

-------------------------------------

-- Select employees whose first name is not 'Mohammed' or 'Mohammad'
SELECT ID, FirstName, LastName 
FROM Employees
WHERE FirstName NOT LIKE 'Mohamm[ae]d';

--------------------

-- Select employees with first name starting with 'a', 'b', or 'c'
SELECT ID, FirstName, LastName 
FROM Employees
WHERE FirstName LIKE 'a%' 
   OR FirstName LIKE 'b%' 
   OR FirstName LIKE 'c%';

-- Search for all employees whose first name starts with 'a', 'b', or 'c'
SELECT ID, FirstName, LastName 
FROM Employees
WHERE FirstName LIKE '[abc]%';

-------------------------------------

-- Search for all employees whose first name starts with any letter from 'a' to 'l'
SELECT ID, FirstName, LastName 
FROM Employees
WHERE FirstName LIKE '[a-l]%';
-------------------------------------

```

















### <span style="color:rgb(0, 176, 240)">Exists </span>

``` SQL
SELECT X = 'yes'
WHERE EXISTS 
(
    SELECT * FROM Orders
    WHERE CustomerID = 3 AND Amount < 600
)

```

### <span style="color:rgb(0, 176, 240)"> Union(sum result in one table)</span>
``` SQL
`
--this will remove the redundancy from the resultset it shold have save record naems
SELECT product_id, product_name
FROM Products_2023
UNION
SELECT product_id, product_name
FROM Products_2024;



`--it return sum resutl of column by with redundancy column
select * from Departments
union ALL
select * from Departments;`

```

### <span style="color:rgb(0, 176, 240)">Case(like if else)</span>
``` SQL
SELECT ID, FirstName, LastName, 
       GendorTitle = CASE 
                       WHEN Gendor = 'M' THEN 'Male' 
                       WHEN Gendor = 'F' THEN 'Female' 
                       ELSE 'Unknown' 
                     END 
FROM Employees;



SELECT ID, FirstName, LastName, 
       GendorTitle = CASE 
                       WHEN Gendor = 'M' THEN 'Male' 
                       WHEN Gendor = 'F' THEN 'Female' 
                       ELSE 'Unknown' 
                     END,
       Status = CASE 
                  WHEN ExitDate IS NULL THEN 'Active' 
                  WHEN ExitDate IS NOT NULL THEN 'Resigned' 
                END 
FROM Employees;


SELECT ID, FirstName, LastName, MonthlySalary, 
       NewSalaryToBe = CASE 
                         WHEN Gendor = 'M' THEN MonthlySalary * 1.1 
                         WHEN Gendor = 'F' THEN MonthlySalary * 1.15 
                       END 
FROM Employees;

```



# <span style="color:rgb(112, 48, 160)">DBMs vs RDBMS</span>

| DBMs                                                           | RDBMS                                                              |
| -------------------------------------------------------------- | ------------------------------------------------------------------ |
| Database Management System                                     | Relational Database Management System                              |
| Data Stored In Files no relations,<br>Uses diffrent datastruct | Data stored In Tabular form<br>(Tables and relations between them) |
|                                                                | Relational                                                         |
|                                                                | SQLServer, Oracle, MySQL                                           |
# <span style="color:rgb(112, 48, 160)">ERD-Generalization - Specialization</span> 
**==ERD:==**  ER Diagram is a structural design of the database.
### <span style="color:rgb(0, 176, 240)">ERD symbols</span>
**==entity:==** table in DB
**==Attribute:==**row in table
==composite attribute== : child of attribute 
 ==Cardinality==:the maximum number of times an instance in one entity can relate to instances of another entity.
  ==Ordinality==:the Minmum number of times an instance in one entity can relate to instances of another entity.

### <span style="color:rgb(0, 176, 240)">Relationships</span>
 One-to-One Relationship.
 One-to-Many Relationship.
 Many-to-One Relationship.
 Many-to-Many Relationshi



### <span style="color:rgb(0, 176, 240)">Generalization - Specialization</span>
**==Generalization==** is the process of extracting common properties from a set of entities and create a generalized entity from it.

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> to make table persoen Then use in user ,studene

**==Specialization==**:an entity is divided into sub-entities based on their characteristics.
**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> like to make table without peseone Attribute , like use be UserName ,permissions,password only



# <span style="color:rgb(112, 48, 160)">Join</span>

Jonin and Inner Join is same
### <span style="color:rgb(0, 176, 240)">Inner) Join</span>
![[inner-join-in-sql.png]]

``` sql 
SELECT Customers.CustomerID, Customers.Name, Orders.Amount
FROM Customers 
JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID;


SELECT Customers.CustomerID, Customers.Name, Orders.Amount
FROM Customers 
INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID;



```

### <span style="color:rgb(0, 176, 240)">Left (Outer) Join</span>
 keyword returns all records from the left table (table1), and the matching records from the right table (table2). The result is 0 records from the right side, if there is no match.

you can make it by query ed
![[left join.gif]]
![[left-join-in-sql.png]]

### <span style="color:rgb(0, 176, 240)">Right (Outer) Join</span>
keyword returns all records from the right table (table2), and the matching records from the left table (table1). The result is 0 records from the left side, if there is no match.




### <span style="color:rgb(0, 176, 240)">Full (Outer) Join</span>
Get the left and right joins in one table
![[full join.gif]]
``` sql 

SELECT Customers.CustomerID, Customers.Name, Orders.Amount 
FROM Customers FULL OUTER JOIN 
Orders ON Customers.CustomerID = Orders.CustomerID
```

### <span style="color:rgb(0, 176, 240)">CROSS JOIN</span>

**Orders Table**

| order_id | product_name | quantity |
|----------|--------------|----------|
| 1        | Book         | 3        |
| 2        | Pen          | 5        |
| 3        | Notebook     | 2        |

**Owners Table**

| owner_id | owner_name   |
|----------|--------------|
| 101      | Alice        |
| 102      | Bob          |

---

Using a `CROSS JOIN` between `Orders` and `Owners` would look like this:

```sql
SELECT * 
FROM Orders 
CROSS JOIN Owners;
```

| order_id | product_name | quantity | owner_id | owner_name |
|----------|--------------|----------|----------|------------|
| 1        | Book         | 3        | 101      | Alice      |
| 1        | Book         | 3        | 102      | Bob        |
| 2        | Pen          | 5        | 101      | Alice      |
| 2        | Pen          | 5        | 102      | Bob        |
| 3        | Notebook     | 2        | 101      | Alice      |
| 3        | Notebook     | 2        | 102      | Bob        |

Each row from the `Orders` table is paired with each row from the `Owners` table, resulting in every possible combination of rows between the two tables.


# <span style="color:rgb(112, 48, 160)">Constraint</span>
### <span style="color:rgb(0, 176, 240)">DEFAULT</span>
``` sql 
CREATE TABLE Persons (  
   ID int NOT NULL,  
   LastName varchar(255) NOT NULL,  
   FirstName varchar(255),  
   Age int,  
   City varchar(255) DEFAULT 'Amman'  
);



CREATE TABLE Orders (  
   ID int NOT NULL,  
   OrderNumber int NOT NULL,  
   OrderDate date DEFAULT GETDATE()  
);

ALTER TABLE Persons  
ADD CONSTRAINT df_City  
DEFAULT 'Amman' FOR City;

--To drop a `DEFAULT` constraint, use the following SQL:
ALTER TABLE Persons  
DROP Constraint  df_City;
```

### <span style="color:rgb(0, 176, 240)">Check</span>
``` sql
CREATE TABLE Persons (  
   ID int NOT NULL,  
   LastName varchar(255) NOT NULL,  
   FirstName varchar(255),  
   Age int CHECK (Age>=18)  
);


CREATE TABLE Persons (  
   ID int NOT NULL,  
   LastName varchar(255) NOT NULL,  
   FirstName varchar(255),  
   Age int,  
   City varchar(255),  
   -- CHK_Person is value you give as duffult
    CONSTRAINT CHK_Person CHECK (Age>=18 AND City='Amman')  
);


--To drop a `CHECK` constraint, use the following SQL:
ALTER TABLE Persons  
DROP CONSTRAINT CHK_Person;

```

### <span style="color:rgb(0, 176, 240)">Uniqu</span>

| Uniqu        | primary key    |
| ------------ | -------------- |
| allow null   | not allow null |
| can repeated | can't repeated |
 <span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)">note</span> Null and Null in columns in repeated
``` sql 
CREATE TABLE Persons (  
   ID int NOT NULL UNIQUE,  
   LastName varchar(255) NOT NULL,  
   FirstName varchar(255),  
   Age int  
);



-- make in to column
CREATE TABLE Persons (  
   ID int NOT NULL,  
   LastName varchar(255) NOT NULL,  
   FirstName varchar(255),  
   Age int,  
    CONSTRAINT UC_Person UNIQUE (ID,LastName)  
);


```



### <span style="color:rgb(0, 176, 240)">Index(Clustered)</span>

it's make i table you can't see to orginze the data to whene need to get (seach)
 git faster 

- in update in much slower becuse it need to make update in normall table and in index table
- Clustered Index is much faster than normal Index.


``` sql
--Creates an index on a table. Duplicate values are allowed:
CREATE INDEX _index_name_  
ON table_name (_column1_, _column2_, ...);


--Creates a unique index on a table. Duplicate values are not allowed:
CREATE UNIQUE INDEX _index_name_  
ON _table_name_ (_column1_, _column2_, ...);

The SQL statement below creates an index named "idx_lastname" on the "LastName" column in the "Persons" table:
CREATE INDEX idx_lastname  
ON Persons (LastName);


CREATE INDEX idx_pname  
ON Persons (LastName, FirstName);

-- delete an index in a table.
DROP INDEX table_name.index_name;
```



# <span style="color:rgb(112, 48, 160)">Normalization</span>

### <span style="color:rgb(0, 176, 240)">First Normal Form 1NF</span>
- Have Primary key
- singel value like  **dont'** make in perosneID(1,2,3)
- no repeting column name
### <span style="color:rgb(0, 176, 240)">Second Normal Form 2NF</span>
- Make first normal form
- shold indpent in one primary key


### <span style="color:rgb(0, 176, 240)">Third Normal Form 3NF</span>
- applied 1nf ,2 nf
- fjdkl


# <span style="color:rgb(112, 48, 160)">GUID(UUID)</span>
function give you a uniq i id  ,**128-bit text string that represents an identification (ID)
<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> 
``` SQL
Select top 10 from qusastions
order by NewID();
```

``` C# 
Guid guid = Guid.NewGuid();
```

``` SQL
SELECT NEWID()
```






---
#                                <span style="color:rgb(112, 48, 160)">T-SQL</span>
---
# <span style="color:rgb(112, 48, 160)">T-SQL</span>
it's like  programing laungue but work on DB

| Feature                      | SQL (Structured Query Language)                                                          | T-SQL (Transact-SQL)                                                      |
| ---------------------------- | ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| **Definition**               | Standard language for querying and managing databases                                    | Microsoft's extension of SQL for SQL Server<br>                           |
| **Vendor**                   | Vendor-agnostic; supported by various database systems (e.g., MySQL, PostgreSQL, Oracle) | Specific to Microsoft SQL Server                                          |
| **Basic Commands**           | Standard SQL commands (SELECT, INSERT, UPDATE, DELETE, etc.)                             | Includes all standard SQL commands plus additional features               |
| **Procedural Extensions**    | Limited procedural capabilities                                                          | Extensive procedural programming capabilities (loops, conditionals, etc.) |
| **Error Handling**           | Basic error handling                                                                     | Advanced error handling with `TRY...CATCH` blocks                         |
| **Variables**                | Limited support for variables                                                            | Full support for variables, including declaration and assignment          |
| **Control-of-Flow**          | Basic control-of-flow statements                                                         | Advanced control-of-flow statements (`IF...ELSE`, `WHILE`, `GOTO`, etc.)  |
| **Built-in Functions**       | Standard set of built-in functions                                                       | Additional built-in functions specific to SQL Server                      |
| **Stored Procedures**        | Basic support for stored procedures                                                      | Advanced support for stored procedures and user-defined functions         |
| **Triggers**                 | Supported by most databases                                                              | Enhanced trigger capabilities in SQL Server                               |
| **User-Defined Functions**   | Supported by most databases                                                              | Advanced user-defined function capabilities                               |
| **Integration**              | Used across various database management systems                                          | Integrated tightly with SQL Server's features and services                |
| **Example Database Systems** | MySQL, PostgreSQL, Oracle, SQLite                                                        | Microsoft SQL Server                                                      |

| Stored proceduer | view         |
| ---------------- | ------------ |
| faster           | slower       |
| do only          | check the do |


# <span style="color:rgb(112, 48, 160)">Variables in T-SQL</span>

``` sql
--Assigning Value
SET @EmployeeName = 'John Doe';
--or 
SELECT @EmployeeName = 'John Doe';

```

``` sql 

use C21_DB1;

-- Example: Employee Report Generation in T-SQL
-- This script demonstrates the declaration, initialization, and use of variables in T-SQL.
-- It generates a report for a specific department, including the department name, reporting period, and total employees hired within that period.
-- This comprehensive script gives a practical insight into how variables can be effectively used in T-SQL to create dynamic and flexible SQL scripts.


-- Step 1: Declare variables
DECLARE @DepartmentID INT; -- Variable for department ID
DECLARE @StartDate DATE; -- Variable for start date
DECLARE @EndDate DATE; -- Variable for end date
DECLARE @TotalEmployees INT; -- Variable to hold the total number of employees
DECLARE @DepartmentName VARCHAR(50); -- Variable for department name

-- Step 2: Initialize variables
SET @DepartmentID = 3; -- Assign a specific department ID
SET @StartDate = '2023-01-01'; -- Set start date for the report
SET @EndDate = '2023-12-31'; -- Set end date for the report

-- Step 3: Retrieve department name based on department ID
SELECT @DepartmentName = Name FROM Departments WHERE DepartmentID = @DepartmentID;

-- Step 4: Calculate the total number of employees in the specified department
SELECT @TotalEmployees = COUNT(*) 
FROM Employees 
WHERE DepartmentID = @DepartmentID 
AND HireDate BETWEEN @StartDate AND @EndDate;

-- Step 5: Print the report
PRINT 'Department Report';
PRINT 'Department Name: ' + @DepartmentName;
PRINT 'Reporting Period: ' + CAST(@StartDate AS VARCHAR) + ' to ' + CAST(@EndDate AS VARCHAR);
PRINT 'Total Employees Hired in ' + CAST(YEAR(@StartDate) AS VARCHAR) + ': ' + CAST(@TotalEmployees AS VARCHAR);

```

``` sql 

/*
In this scenario, we'll use T-SQL variables to generate a monthly sales summary report for a given year and month. 
This report will include total sales, number of transactions, and average sale value. 
We'll need a Sales table that contains details of each sale.
*/

-- This script generates a monthly sales summary report.
-- It includes total sales, total number of transactions, and the average sale value for a specified month and year.

-- Declare variables
DECLARE @Year INT;
DECLARE @Month INT;
DECLARE @TotalSales DECIMAL(10, 2);
DECLARE @TotalTransactions INT;
DECLARE @AverageSale DECIMAL(10, 2);

-- Initialize variables
SET @Year = 2023; -- Set the year for the report
SET @Month = 6; -- Set the month for the report

-- Calculate total sales for the specified month and year
SELECT @TotalSales = SUM(SaleAmount)
FROM Sales
WHERE YEAR(SaleDate) = @Year AND MONTH(SaleDate) = @Month;

-- Calculate the total number of transactions
SELECT @TotalTransactions = COUNT(*)
FROM Sales
WHERE YEAR(SaleDate) = @Year AND MONTH(SaleDate) = @Month;

-- Calculate the average sale value
SET @AverageSale = @TotalSales / @TotalTransactions;

-- Print the report
PRINT 'Monthly Sales Summary Report';
PRINT 'Year: ' + CAST(@Year AS VARCHAR) + ', Month: ' + CAST(@Month AS VARCHAR);
PRINT 'Total Sales: ' + CAST(@TotalSales AS VARCHAR);
PRINT 'Total Transactions: ' + CAST(@TotalTransactions AS VARCHAR);
PRINT 'Average Sale Value: ' + CAST(@AverageSale AS VARCHAR);


```


# <span style="color:rgb(112, 48, 160)">IF else </span>

- BEGIN LIKE { } in c#




**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> :Simple if
``` sql
Declare @a int, @b int;
set @a = 20;
set @b=10;

IF @a > @b
	BEGIN
		PRINT 'Yes A is greater than B'
	END
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> :if . else
``` sql
Declare @year int;
set @year =2001;

IF @year >= 2000
    BEGIN
        PRINT '21st century'
    END
ELSE
    BEGIN
        PRINT '20th century or earlier'
    END
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> :Nested IF
``` sql
Declare  @score int;
set @score = 92;

IF @score >= 90
	BEGIN
		PRINT 'Grade A'
	END
ELSE
	BEGIN
		IF @score >= 80
			BEGIN
				PRINT 'Grade B'
			END
		ELSE
			BEGIN
				PRINT 'Grade C or lower'
			END
	END
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> :Error Handling with IF
``` sql
IF @@ERROR <> 0
BEGIN
    PRINT 'An error occurred.'
END
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> IF with EXISTS
``` sql
IF EXISTS (SELECT * FROM Employees WHERE Name = 'John Smith')
	BEGIN
		PRINT 'Yes, John Smith is there.'
	END
ELSE
	BEGIN
		PRINT 'No, John Smith is there.'
	END
```

# <span style="color:rgb(112, 48, 160)">Case (like swich)</span>
T-SQL does not have a dedicated `SWITCH` statement as found in many programming languages

- use only inside the query only

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> :Simple case
``` sql
SELECT 
    EmployeeID,
    CASE DepartmentID
        WHEN 1 THEN 'Engineering'
        WHEN 2 THEN 'Human Resources'
        WHEN 3 THEN 'Sales'
        ELSE 'Other'
    END AS DepartmentName
FROM Employees;
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> Searched CASE
``` sql
SELECT 
    EmployeeID,
    CASE 
        WHEN Salary <= 30000 THEN 'Entry Level'
        WHEN Salary BETWEEN 30001 AND 60000 THEN 'Mid Level'
        WHEN Salary > 60000 THEN 'Senior Level'
        ELSE 'Not Specified'
    END AS EmployeeLevel
FROM Employees;
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> :CASE in ORDER BY
``` sql
SELECT Name, Salary
FROM Employees
ORDER BY 
    CASE 
        WHEN Salary > 50000 THEN 1
        ELSE 2
    END;
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> :UPDATE
``` sql
UPDATE Employees2
SET Salary = 
    CASE 
        WHEN PerformanceRating > 90 THEN Salary * 1.15
        WHEN PerformanceRating BETWEEN 75 AND 90 THEN Salary *                                                             1.10
		WHEN PerformanceRating BETWEEN 50 AND 74 THEN Salary *                                                           1.05
        ELSE Salary
    END;
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> :Nested Case
``` sql
SELECT
    Name,
    Department,
    Salary,
    PerformanceRating,
    Bonus = CASE 
                WHEN Department = 'Sales' THEN
                    CASE 
                        WHEN PerformanceRating > 90 THEN Salary * 0.15
                        WHEN PerformanceRating BETWEEN 75 AND 90 THEN Salary * 0.10
                        ELSE Salary * 0.05
                    END
                WHEN Department = 'HR' THEN
                    CASE 
                        WHEN PerformanceRating > 90 THEN Salary * 0.10
                        WHEN PerformanceRating BETWEEN 75 AND 90 THEN Salary * 0.08
                        ELSE Salary * 0.04
                    END
                ELSE
                    CASE 
                        WHEN PerformanceRating > 90 THEN Salary * 0.08
                        WHEN PerformanceRating BETWEEN 75 AND 90 THEN Salary * 0.06
                        ELSE Salary * 0.03
                    END
            END
FROM Employees2;
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> :CASE within a GROUP BY
``` sql
SELECT
    PerformanceCategory,
    COUNT(*) AS NumberOfEmployees,
    AVG(Salary) AS AverageSalary
FROM
    (SELECT
        Name,
        Salary,
        CASE
            WHEN PerformanceRating >= 80 THEN 'High'
            WHEN PerformanceRating >= 60 THEN 'Medium'
            ELSE 'Low'
        END AS PerformanceCategory
    FROM Employees2) AS PerformanceTable
GROUP BY PerformanceCategory;
```


# <span style="color:rgb(112, 48, 160)">Loops Statements </span>

- there are no `FOR` or `DO WHILE` in t-sql
**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> :Simple WHILE Loops
``` sql
	DECLARE @Counter INT = 1;

	--This loop prints numbers from 1 to 5.
	WHILE @Counter <= 5
	BEGIN
		PRINT 'Count: ' + CAST(@Counter AS VARCHAR);
		SET @Counter = @Counter + 1;
	END

	Print '';
	Print 'Revered Counter';

	--This loop prints numbers from 5 to 1.
	set @Counter= 5;

	WHILE @Counter > 0
	BEGIN
		PRINT 'Count: ' + CAST(@Counter AS VARCHAR);
		SET @Counter = @Counter - 1;
	END
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> :Iterating Over a Table
``` sql

use C21_DB1;

--This loop iterates over each employee in the Employees table.

DECLARE @EmployeeID INT;
DECLARE @Name varchar(50);
DECLARE @MaxID INT;

-- Initialize the starting point
SELECT @EmployeeID = MIN(EmployeeID) FROM Employees;

-- Find the maximum EmployeeID
SELECT @MaxID = MAX(EmployeeID) FROM Employees;

-- Loop through employees
WHILE @EmployeeID IS NOT NULL AND @EmployeeID <= @MaxID
BEGIN
    -- Perform an operation, e.g., print employee's name
    SELECT @Name=Name FROM Employees WHERE EmployeeID = @EmployeeID;
	PRINT @Name;

    -- Get the next EmployeeID
    SELECT @EmployeeID = MIN(EmployeeID) FROM Employees WHERE EmployeeID > @EmployeeID;

END

```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> :Nested While Loops
``` sql
DECLARE @row INT = 1;
-- Example 4 - Nested While Loops - 10 x 10 Multiplication Table
DECLARE @col INT;
DECLARE @result INT;

WHILE @row <= 10
BEGIN
    SET @col = 1;
    WHILE @col <= 10
    BEGIN
        SET @result = @row * @col;
        PRINT CAST(@row AS VARCHAR) + ' x ' + CAST(@col AS VARCHAR) + ' = ' + CAST(@result AS VARCHAR);
        SET @col = @col + 1;
    END
    SET @row = @row + 1;
END

```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> :BREAK and CONTINUE Statements
``` sql

DECLARE @counter INT = 1;

--Break Example
--This loop will print numbers from 1 to 5. When the counter reaches 5, the BREAK statement exits the loop.
 PRINT 'Break Example: ' ;
WHILE @counter <= 10
BEGIN
    PRINT 'Counter: ' + CAST(@counter AS VARCHAR);
    IF @counter = 5
    BEGIN
        BREAK; -- Exits the loop when counter reaches 5
    END
    SET @counter = @counter + 1;
END


--This loop will print only odd numbers between 1 and 10. When the counter is even, the CONTINUE statement skips to the next iteration.
PRINT '' ;
PRINT 'Continue Example: ' ;
set @counter=1;


WHILE @counter <= 10
BEGIN
    SET @counter = @counter + 1;
    IF @counter % 2 = 0
    BEGIN
        CONTINUE; -- Skips the current iteration for even numbers
    END
    PRINT 'Counter: ' + CAST(@counter AS VARCHAR);
END

```


# <span style="color:rgb(112, 48, 160)">BEGIN...END Blocks</span>
 - iti's like  { } in c#

# <span style="color:rgb(112, 48, 160)">Error Handling / Try .. Catch</span>

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> :Simple try..catch
``` sql
	-- Assume we have a table called 'Employees' with a unique constraint on 'EmployeeID'
CREATE TABLE Employees3 (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Position NVARCHAR(100)
);


BEGIN TRY
    -- Insert a record into the Employees table
    INSERT INTO Employees3 (EmployeeID, Name, Position) VALUES (1, 'John Doe', 'Sales Manager');
    
    -- Attempt to insert a duplicate record which will cause an error
    INSERT INTO Employees3 (EmployeeID, Name, Position) VALUES (1, 'Jane Smith', 'Marketing Manager');
END TRY
BEGIN CATCH
    -- Handle the error
    PRINT 'An error occurred: ' + ERROR_MESSAGE();
    -- Rollback the transaction if any
END CATCH
```
### <span style="color:rgb(0, 176, 240)">Error Functions</span>
- `ERROR_NUMBER()`: Returns the error number.
- `ERROR_SEVERITY()`: Returns the severity level of the erro,Severity levels range from 0 to 25.
- `ERROR_STATE()`: Returns the error state number.
- `ERROR_PROCEDURE()`: Returns the name of the stored procedure or trigger where the error occurred.
- `ERROR_LINE()`: Returns the line number where the error occurred.
- `ERROR_MESSAGE()`: Returns the complete text of the error message.




### <span style="color:rgb(0, 176, 240)">THROW Statement</span>
it's a error messeage you write  contain 

- error_number: A constant or variable between 50,000 and 2,147,483,647.
- message: The error message text. It should be a string less than 2048
- characters.•state: A constant or variable between 0 and 255.

```
THROW [error_number, message, state];
```


**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> :Simple try..catch
``` sql
declare @NewStockQty INT;


	set @NewStockQty=-5;

    -- Start a TRY block
    BEGIN TRY
        -- Check if NewStockQty is negative
        IF @NewStockQty < 0
            THROW 51000, 'Stock quantity cannot be negative.', 1;


        -- Proceed with updating stock (example code)
        UPDATE Products SET StockQuantity = @NewStockQty WHERE ProductID = 1;
    END TRY


    -- Start a CATCH block to handle the error
    BEGIN CATCH
        SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
```


# <span style="color:rgb(112, 48, 160)">Special Variables</span>

@@IDENTITY: Contains the last-inserted identity value.
@@ROWCOUNT: Contains the number of rows affected by the last statement.
@@ERROR: return 0 if no erro in there errro return errro number

# <span style="color:rgb(112, 48, 160)">Transactions</span>

``` sql

BEGIN TRANSACTION;


BEGIN TRY
    -- Subtract $100 from Account 1
    UPDATE Accounts SET Balance = Balance - 100 WHERE AccountID = 1;


    -- Add $100 to Account 2
    UPDATE Accounts SET Balance = Balance + 100 WHERE AccountID = 2;


    -- Log the transaction
    INSERT INTO Transactions (FromAccount, ToAccount, Amount, Date) VALUES (1, 2, 100, GETDATE());



    COMMIT; --COMMIT: mean you can put the data now
END TRY
BEGIN CATCH
    -- Rollback in case of error
    ROLLBACK;--ROLLBACK:Delete data from log file
    -- Error handling code here
END CATCH;
```


###  <span style="color:rgb(0, 176, 240)">ACID</span>
**ACID** is an acronym that stands for Atomicity, Consistency, Isolation, and Durability. These properties ensure reliable processing of database transactions.

1. **Atomicity**: Ensures that all operations within a transaction are completed successfully. If any operation fails, the entire transaction is aborted and the database is left unchanged.
   
   - **Example**: In a bank transfer, both the debit from one account and the credit to another must either both succeed or both fail. If one part of the transaction fails, the entire transaction is rolled back.

2. **Consistency**: Ensures that a transaction brings the database from one valid state to another, adhering to all predefined rules and constraints. If a transaction violates any constraints, it will not be committed.
   
   - **Example**: If a database rule requires that account balances cannot be negative, any transaction that would result in a negative balance will be rolled back.

3. **Isolation**: Ensures that transactions are executed in isolation from one another. Intermediate states of a transaction are not visible to other transactions until the transaction is complete.
   
   - **Example**: When two transactions are updating the same set of data, each transaction will operate as if it is the only one interacting with the data until it is completed.

4. **Durability**: Ensures that once a transaction has been committed, it will remain so, even in the event of a system failure. This is often achieved by writing transaction data to a log file.
   
   - **Example**: If a transaction completes successfully but the system crashes immediately afterward, the changes made by the transaction will still be preserved when the system is restarted.






# <span style="color:rgb(112, 48, 160)">Variable Tables</span>
Table variables in T-SQL are used to store a set of records temporarily,stored in momery to in disk.

- scop to the batch
- faster then normall table
- les use log file

``` sql 

	-- Declare a table variable named @EmployeesTable
	-- This table variable is stored in memory 
	--  and is scoped to the batch, stored procedure, or function
	DECLARE @EmployeesTable TABLE (
		EmployeeId INT,
		Name VARCHAR(100),
		Department VARCHAR(50)
	);

	-- Insert records into the @EmployeesTable table variable
	INSERT INTO @EmployeesTable (EmployeeId, Name, Department)
	VALUES (10, 'Mohammed', 'Marketing');

	INSERT INTO @EmployeesTable (EmployeeId, Name, Department)
	VALUES (11, 'Ali', 'Sales');

	-- Query the table variable

	SELECT * FROM @EmployeesTable WHERE Department = 'Sales';

	-- No need to drop the table variable
	-- The table variable @EmployeesTable automatically goes out of scope and is deallocated
	-- at the end of the execution of the batch, stored procedure, or function

```

# <span style="color:rgb(112, 48, 160)">Temporary Tables</span>

| Temporary Tables | Variable Tables |
| ---------------- | --------------- |
| in tempdb in sql | in memory       |
| take big data    | take small data |

``` SQL 


	-- Create a local temporary table named #EmployeesTemp
	-- This table will be stored in the tempdb database and is visible only to this session
	CREATE TABLE #EmployeesTemp (
		EmployeeId INT,
		Name VARCHAR(100),
		Department VARCHAR(50)
	);

	-- Insert a records into the #EmployeesTemp table
	INSERT INTO #EmployeesTemp (EmployeeId, Name, Department)
	VALUES (10, 'Mohammed', 'Marketing');

	INSERT INTO #EmployeesTemp (EmployeeId, Name, Department)
	VALUES (11, 'Ali', 'Sales');

	-- Query the table
	SELECT * FROM #EmployeesTemp WHERE Department = 'Sales';

	-- Drop (delete) the temporary table #EmployeesTemp
	-- This is a good practice to clean up, although the table would automatically be deleted
	-- when the session ends
	DROP TABLE #EmployeesTemp;



```
#### **<span style="color:rgb(0, 176, 240)">Types of Temporary Tables</span>**

1-Local Temporary Tables: Created with a single hash (`#`) symbol. Visible only to the connection that creates it and are deleted when the connection is closed.
``` SQL
CREATE TABLE #TempTable (...)
```

2-Global Temporary Tables: Created with a double hash (`##`) symbol. Visible to all connections and are deleted when the last connection using it is closed.
``` SQL
CREATE TABLE ##TempTable (...)
```




# <span style="color:rgb(112, 48, 160)">Stored Procedures</span>

| Stored Procedures | view | function |
| ----------------- | ---- | -------- |
| faster            |      |          |
|                   |      |          |
- slow in first execute but then be  faster


**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span>  Get proceeduer info
``` SQL
EXEC sp_helptext 'YourStoredProcedureName';
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> add
``` sql
CREATE PROCEDURE SP_AddNewPerson
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100),
    @Email NVARCHAR(255),
    @NewPersonID INT OUTPUT
AS
BEGIN
    INSERT INTO People (FirstName, LastName, Email)
    VALUES (@FirstName, @LastName, @Email);


    SET @NewPersonID = SCOPE_IDENTITY();
END
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> execute
``` sql
EXEC SP_GetAllPeople;
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span>  Get Person By ID return as record**
``` sql
CREATE PROCEDURE SP_GetPersonByID
    @PersonID INT
AS
BEGIN
    SELECT * FROM People WHERE PersonID = @PersonID
END


execute
EXEC SP_GetPersonByID
		@PersonID = 1
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span>  Get perseon by ID return as parmatter
``` sql
CREATE PROCEDURE SP_GetPersonByID2
    @PersonID INT,
    @FirstName NVARCHAR(100) OUTPUT,
    @LastName NVARCHAR(100) OUTPUT,
    @Email NVARCHAR(255) OUTPUT,
    @IsFound BIT OUTPUT  -- Additional parameter to indicate if a record was found
AS
BEGIN
    IF EXISTS(SELECT 1 FROM People WHERE PersonID = @PersonID)
    BEGIN
        SELECT 
            @FirstName = FirstName, 
            @LastName = LastName, 
            @Email = Email
        FROM People 
        WHERE PersonID = @PersonID;


        SET @IsFound = 1;  -- Set to 1 (true) if a record is found
    END
    ELSE
    BEGIN
        SET @IsFound = 0;  -- Set to 0 (false) if no record is found
    END
END
```
``` sql

DECLARE @ID INT = 1;  -- Example PersonID
DECLARE @FName NVARCHAR(100);
DECLARE @LName NVARCHAR(100);
DECLARE @Email NVARCHAR(255);
DECLARE @Found BIT;


EXEC SP_GetPersonByID2
    @PersonID = @ID,
    @FirstName = @FName OUTPUT,
    @LastName = @LName OUTPUT,
    @Email = @Email OUTPUT,
    @IsFound = @Found OUTPUT;


IF @Found = 1
    SELECT @FName as FirstName, @LName as LastName, @Email as Email;
ELSE
    PRINT 'Person not found';
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span>  Update a Person's**
``` sql
CREATE PROCEDURE SP_UpdatePerson
    @PersonID INT,
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100),
    @Email NVARCHAR(255)
AS
BEGIN
    UPDATE People
    SET FirstName = @FirstName, LastName = @LastName, Email = @Email
    WHERE PersonID = @PersonID
END



EXEC SP_UpdatePerson 
    @PersonID = 1, -- The ID of the person you want to update
    @FirstName = 'UpdatedFirstName',
    @LastName = 'UpdatedLastName',
    @Email = 'updated.email@example.com';
    
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span>  Delete persoen
``` sql
CREATE PROCEDURE SP_DeletePerson
    @PersonID INT
AS
BEGIN
    DELETE FROM People WHERE PersonID = @PersonID
END

USE C21_DB1;

EXEC	 SP_DeletePerson
		@PersonID = 4
```

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span>  Person Exists  +  RETURN Statement
``` SQL
CREATE PROCEDURE SP_CheckPersonExists
    @PersonID INT
AS
BEGIN
    IF EXISTS(SELECT * FROM People WHERE PersonID = @PersonID)
        RETURN 1;  -- Person exists
    ELSE
        RETURN 0;  -- Person does not exist
END






DECLARE @Result INT;
EXEC @Result = SP_CheckPersonExists @PersonID = 123; -- Replace 123 with the actual PersonID
IF @Result = 1
    PRINT 'Person exists.';
ELSE
    PRINT 'Person does not exist.';
```




**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span>  
``` SQL

```
# <span style="color:rgb(112, 48, 160)">Built-In Functions</span>

### <span style="color:rgb(0, 176, 240)">string function </span>
``` sql
use C21_DB1;

--Common String Functions...

-- Using the LEN function to get the length of each employee's name
SELECT LEN(Name) AS NameLength FROM dbo.Employees2
GO

-- Converting employee names to uppercase using the UPPER function
SELECT UPPER(Name) AS UpperCaseName FROM dbo.Employees2
GO

-- Converting employee names to lowercase using the LOWER function
SELECT LOWER(Name) AS UpperCaseName FROM dbo.Employees2
GO

-- Extracting the first three characters of each name using SUBSTRING
SELECT SUBSTRING(Name, 1, 3) AS NameSubstring FROM dbo.Employees2
GO

-- Finding the position of '0' in each name using CHARINDEX
SELECT CHARINDEX('o', Name) AS CharPosition FROM dbo.Employees2
GO

-- Replacing 'Sales' with 'Marketing' in department names using REPLACE
SELECT REPLACE(Department, 'Sales', 'Marketing') AS NewDepartment FROM dbo.Employees2
GO

-- Concatenating the name and department with a hyphen in between using CONCAT
SELECT CONCAT(Name, ' - ', Department) AS ConcatenatedString FROM dbo.Employees2
GO

-- Practice Exercise: Format Name and Department in a specific format using CONCAT, UPPER, and LOWER
-- Objective: Format the Name and Department columns as a single string, where names are in uppercase, and department names are in lowercase, separated by a colon (:)
SELECT CONCAT(UPPER(Name), ' : ', LOWER(Department)) AS FormattedOutput FROM dbo.Employees2
GO

-- Extracting the first 3 characters from the left side of the employee's name using LEFT
SELECT LEFT(Name, 3) AS LeftSubstring FROM dbo.Employees2
GO

-- Extracting the last 3 characters from the right side of the employee's name using RIGHT
SELECT RIGHT(Name, 3) AS RightSubstring FROM dbo.Employees2
GO

-- Removing leading spaces from the employee's name using LTRIM
SELECT LTRIM(Name) AS NameWithNoLeadingSpaces FROM dbo.Employees2
GO

-- Removing trailing spaces from the employee's name using RTRIM
SELECT RTRIM(Name) AS NameWithNoTrailingSpaces FROM dbo.Employees2
GO


-- Removing spaces from the start and end of each name using LTRIM and RTRIM
SELECT LTRIM(RTRIM(Name)) AS TrimmedName FROM dbo.Employees2
GO

-- Removing both leading and trailing spaces from the employee's name using TRIM
SELECT TRIM(Name) AS NameWithNoSpaces FROM dbo.Employees2
GO




```

### <span style="color:rgb(0, 176, 240)">Data functions</span>
``` sql
use C21_DB1;

-- Common Date funcitons:

-- Getting the current system date and time
SELECT GETDATE() AS CurrentDateTime
GO

-- Getting the system date and time with fractional seconds and time zone offset
SELECT SYSDATETIME() AS SystemDateTime
GO

-- Adding 10 days to the current date
SELECT DATEADD(day, 10, GETDATE()) AS DatePlus10Days
GO

-- Calculating the difference in days between two dates
SELECT DATEDIFF(day, '2023-01-01', GETDATE()) AS DaysSinceStartOfYear
GO

-- Extracting the year part from the current date
SELECT DATEPART(year, GETDATE()) AS CurrentYear
GO

-- Getting the name of the current month
SELECT DATENAME(month, GETDATE()) AS CurrentMonthName
GO

-- Extracting the day from the current date
SELECT DAY(GETDATE()) AS CurrentDay
GO

-- Extracting the month from the current date
SELECT MONTH(GETDATE()) AS CurrentMonth
GO

-- Extracting the year from the current date
SELECT YEAR(GETDATE()) AS CurrentYear
GO

-- Converting a datetime to a different format,The third argument, 103, specifies the style code for the conversion. 
--In SQL Server, style code 103 represents the date format as DD/MM/YYYY. 
--This means that the resulting string will have the day, then the month, and finally the year, separated by forward slashes.
SELECT CONVERT(varchar, GETDATE(), 103) AS DateInDDMMYYYY
GO

-- Casting a datetime to a different data type
SELECT CAST(GETDATE() AS date) AS DateOnly
GO

-- Getting the last day of the current month
SELECT EOMONTH(GETDATE()) AS LastDayOfCurrentMonth
GO



```
### <span style="color:rgb(0, 176, 240)">Aggregate functions (SUM, AVG, COUNT, MIN, MAX)</span>
``` sql 
USE [C21_DB1]
Go

-- Description: Count the number of employees in each department
SELECT Department, COUNT(*) AS EmployeeCount
FROM Employees2
GROUP BY Department;

-- Description: Calculate the total salary for each department
SELECT Department, SUM(Salary) AS TotalSalary
FROM Employees2
GROUP BY Department;

-- Description: Calculate the average performance rating for each department
SELECT Department, AVG(PerformanceRating) AS AvgPerformanceRating
FROM Employees2
GROUP BY Department;

-- Description: Find the lowest salary in the company
SELECT MIN(Salary) AS LowestSalary
FROM Employees2;

-- Description: Find the highest salary in the company
SELECT MAX(Salary) AS HighestSalary
FROM Employees2;

```
# <span style="color:rgb(112, 48, 160)">Window Functions:</span>


ROW_NUMBER():give record number form 1 to the num of record
``` sql
SELECT 
    StudentID, 
    Name, 
    Subject, 
    Grade,
    ROW_NUMBER() OVER (ORDER BY Grade DESC) AS RowNum
FROM 
    Students;
```

 RANK():
``` sql
 SELECT 
    StudentID, 
    Name, 
    Subject, 
    Grade,
    RANK() OVER (ORDER BY Grade DESC) AS GradeRank
FROM 
    Students;
```


# <span style="color:rgb(112, 48, 160)">Scalar Functions</span>

# <span style="color:rgb(112, 48, 160)">Table-Valued Functions</span>
# <span style="color:rgb(112, 48, 160)">Dynamic SQL and SQL Injection Attack</span>
# <span style="color:rgb(112, 48, 160)">Triggers</span>
# <span style="color:rgb(112, 48, 160)">After Triggers</span>
# <span style="color:rgb(112, 48, 160)">Instead of Triggers</span>
# <span style="color:rgb(112, 48, 160)">Cursors in T-SQL</span>
# <span style="color:rgb(112, 48, 160)">Null if & ISNULL</span>

##### <span style="color:rgb(0, 176, 240)">null if</span>
```sql 
SELECT 
  total_sales,
  number_of_sales,
  total_sales / NULLIF(number_of_sales, 0) AS average_sale
FROM Sales;

- If `number_of_sales` is `0`, `NULLIF` returns `NULL`, and the result will also be `NULL` (avoiding division by zero).

- If `number_of_sales` is not `0`, the division proceeds as normal.

```

``` sql 

SELECT 
  product_name,
  NULLIF(discount_code, '') AS discount_code
FROM Products;


- If `discount_code` is an empty string, `NULLIF` converts it to `NULL`.
- 
- If `discount_code` has a value, it is returned as usual.
```


##### <span style="color:rgb(0, 176, 240)">Is null</span> 
``` sql
SELECT 
  customer_id, 
  ISNULL(phone_number, 'Not Provided') AS phone_number
FROM Customers;

- If `phone_number` is `NULL`, the result will show `"Not Provided"`.

- If `phone_number` has a value, it will display as usual.
```

``` sql
SELECT 
  employee_id,
  first_name + ' ' + ISNULL(middle_name, '') AS full_name
FROM Employees;

- `ISNULL(middle_name, '')` replaces `NULL` with an empty string.

- The `+` operator concatenates `first_name` and `middle_name`, ensuring there are no extra spaces or `NULL` values in `full_name`.
```

# <span style="color:rgb(112, 48, 160)">COALESCE</span> 
``` sql
SELECT 
    CustomerName,
    COALESCE(PhoneNumber, 'No phone number available') AS Phone
FROM 
    Customers;
    
If the `PhoneNumber` is `NULL`, the query will return `'No phone number available'` instead.

```

``` sql
SELECT 
    UserName,
    COALESCE(Email, PhoneNumber) AS PreferredContact
FROM 
    Users;

`COALESCE` returns the `Email` if it's not `NULL`; otherwise, it returns the `PhoneNumber`.
```


# WITH
In SQL, `WITH` is used to define a **Common Table Expression (CTE)**, which allows you to create a temporary result set that you can reference within the main `SELECT`, `INSERT`, `UPDATE`, or `DELETE` query. It’s especially useful for organizing complex queries, making them more readable, and optimizing certain operations by reusing the result in the main query.

```sql 
WITH CTE_Name AS (
    -- CTE query goes here
    SELECT column1, column2
    FROM SomeTable
    WHERE condition
)
-- Main query using the CTE
SELECT *
FROM CTE_Name

```


```sql
--Using Multiple CTEs
WITH SalesSummary AS (
    SELECT product_id, SUM(quantity) AS total_quantity
    FROM Sales
    GROUP BY product_id
),
ProductInfo AS (
    SELECT product_id, product_name
    FROM Products
)
SELECT p.product_name, s.total_quantity
FROM ProductInfo p
JOIN SalesSummary s ON p.product_id = s.product_id;


--In this case, `SalesSummary` and `ProductInfo` are two separate CTEs, and the main query combines them to display the product name along with the total quantity sold.

```