USE TestDB;
GO
------------------------------------------------
-- Query 1
CREATE TABLE	dbo.Customer
(		CustomerID	INT NOT NULL,
		FirstName	VARCHAR(50),
		LastName	VARCHAR(50),
		Email	VARCHAR(100),
		ModifiedDate	DATE,
		CONSTRAINT PK_Customer_CustomerID	
			PRIMARY KEY CLUSTERED (CustomerID)
);
GO
------------------------------------------------
-- Query 2
CREATE NONCLUSTERED INDEX IX_Customer_FirstName_LastName
	ON dbo.Customer
(
		FirstName ASC,
		LastName ASC
);
GO
------------------------------------------------
-- Query 3
CREATE INDEX IX_Customer_ModifiedDate 
	ON dbo.Customer (ModifiedDate)
	INCLUDE (FirstName, LastName);
GO

SELECT FirstName
,LastName
FROM dbo.Customer
WHERE ModifiedDate = '2020-10-20';
GO
------------------------------------------------
-- Query 4
CREATE TABLE dbo.Customer2
(		CustomerID	INT NOT NULL,
		AccountNumber	VARCHAR(10) NOT NULL,		
		FirstName	VARCHAR(50),
		LastName	VARCHAR(50),
		Email	VARCHAR(100),
		ModifiedDate	DATE,
);

CREATE CLUSTERED INDEX CI_Customer_ID
	ON	dbo.Customer2(AccountNumber);

ALTER TABLE dbo.Customer2
	ADD CONSTRAINT 
		PK_CustomerID PRIMARY KEY NONCLUSTERED(CustomerID);
GO
-- DROP TABLE dbo.Customer2
------------------------------------------------
-- Query 5
EXEC SP_RENAME 
	N'dbo.Customer2.CI_Customer_ID', 
	N'CI_CustomerID',
	N'INDEX'; 
GO
------------------------------------------------
-- Query 6

DROP INDEX CI_CustomerID ON dbo.Customer2
------------------------------------------------
-- Query 7
CREATE UNIQUE NONCLUSTERED INDEX AK_Customer_Email
	ON dbo.Customer2 (Email);
GO
------------------------------------------------
-- Query 8
CREATE NONCLUSTERED INDEX IX_Customer2_ModifiedDate
	ON dbo.Customer2 (ModifiedDate)
	WITH (FILLFACTOR = 70);
GO

