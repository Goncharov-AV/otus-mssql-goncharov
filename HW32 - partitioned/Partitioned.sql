-- Add filegroup
ALTER DATABASE [Partitioned]
ADD FILEGROUP [SECONDARY];
GO  

-- Add file
ALTER DATABASE [Partitioned]
ADD FILE   
(  
    NAME = N'Partitioned_SECONDARY',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Partitioned_SECONDARY.ndf',  
    SIZE = 5MB,  
    MAXSIZE = 100MB,  
    FILEGROWTH = 5MB  
)  
TO FILEGROUP [SECONDARY];

-- Partition function
--DROP PARTITION FUNCTION [PF_BIRTH_DATE]
CREATE PARTITION FUNCTION [PF_BIRTH_DATE] (DATETIME2)  
AS RANGE LEFT FOR VALUES ('0001-01-01', '1900-01-01')

-- Partition scheme
--DROP PARTITION SCHEME [PS_BIRTH_DATE]
CREATE PARTITION SCHEME [PS_BIRTH_DATE] AS PARTITION [PF_BIRTH_DATE] ALL TO ([PRIMARY])

--Create table
--DROP TABLE [dbo].[Persons]
CREATE TABLE [dbo].[Persons]
(
	[PersonId] INT IDENTITY(1,1) NOT NULL,
	[PersonImdbId] NVARCHAR(255),
	[Name] NVARCHAR(255),
	[Summary] NVARCHAR(MAX),
	[BirthDate] DATETIME2 NOT NULL,
	[DeathDate] DATETIME2
) ON [PS_BIRTH_DATE]([BirthDate])
GO

ALTER TABLE [dbo].[Persons] ADD CONSTRAINT PK_dbo_Persons
PRIMARY KEY CLUSTERED ([BirthDate],[PersonId])
GO

-- Fill table
INSERT INTO [dbo].[Persons](PersonImdbId,Name,Summary,BirthDate,DeathDate)
SELECT PersonImdbId,Name,Summary,BirthDate,DeathDate FROM AMDB.Names.Persons WHERE BirthDate IS NOT NULL
GO

--
SELECT * FROM [dbo].[Persons]
--TRUNCATE TABLE [dbo].[Persons]

-- Check
SELECT  $PARTITION.PF_BIRTH_DATE (BirthDate) AS Partition,
		PersonImdbId,
		Name,
		Summary,
		BirthDate,
		DeathDate
FROM [dbo].[Persons]

