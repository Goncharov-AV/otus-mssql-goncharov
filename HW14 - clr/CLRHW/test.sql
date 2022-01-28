CREATE ASSEMBLY SimpleDemoAssembly
FROM 'c:\_Sources\otus-mssql-goncharov\HW14 - clr\CLRHW\bin\Release\CLRHW.dll'
WITH PERMISSION_SET = SAFE;  

-- DROP ASSEMBLY SimpleDemoAssembly

SELECT * FROM sys.assemblies
GO;

CREATE FUNCTION dbo.IpChecker(@ip nvarchar(100))  
RETURNS int
AS EXTERNAL NAME [SimpleDemoAssembly].[CLRHW.CustomFunction].IpChecker;
GO 

SELECT dbo.IpChecker('adfhfg')
SELECT dbo.IpChecker('192.168.1.1')
SELECT dbo.IpChecker('192.168.1.256')