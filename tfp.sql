USE AdventureWorks2019;
GO

--query 1
CREATE TRIGGER	notifier
ON	HumanResources.Department
AFTER	INSERT, UPDATE
AS
THROW	51000, 'you cannot change this table', 1;
GO

-- INSERT INTO HumanResources.Department VALUES ('KA','D', '2008-04-30 00:00:00.000')
select * from HumanResources.Department;

-- query 2
CREATE TRIGGER	notifier2
ON	DATABASE
FOR	ALTER_TABLE
AS
THROW	51000, 'you cannot change any table', 1;
GO

-- ALTER TABLE	HumanResources.Shift 
-- ADD	email VARCHAR(20)

-- query 3
CREATE FUNCTION	dbo.ufnConcatStrings 
( @Var1	VARCHAR(30)
, @Var2	VARCHAR(30)
)
RETURNS VARCHAR(61)
AS 
BEGIN
	DECLARE	@ConcatStrings VARCHAR(61)
	SELECT	@ConcatStrings = (CONCAT_WS('-', @Var1, @Var2 ))
	RETURN	@ConcatStrings
END;
GO

/*
SELECT	dbo.ufnConcatStrings
	(d.Name
	, d.ModifiedDate) 
FROM	HumanResources.Department AS d;
*/

-- query 4
CREATE FUNCTION	HumanResources.ufnEmployeeByDepartment (@Id INTEGER)
RETURNS TABLE
AS 
RETURN
(
	SELECT	e.* 
	FROM	HumanResources.Employee AS e
	JOIN	HumanResources.EmployeeDepartmentHistory AS edh
		ON	e.BusinessEntityID = edh.BusinessEntityID
	WHERE	edh.DepartmentID = @Id
)
;
GO

-- SELECT	*
-- FROM	HumanResources.ufnEmployeeByDepartment (1)

-- query 5
CREATE PROCEDURE	Person.uspSearchByName
	@Name	VARCHAR(30) = NULL
AS
SELECT 
	p.BusinessEntityId 
	, p.FirstName
	, p.LastName
FROM	Person.Person AS p
WHERE	FirstName	LIKE	'%' + @Name + '%'
	OR	LastName	LIKE	'%' + @Name + '%';
GO

-- EXECUTE	Person.uspSearchByName 'ess'


