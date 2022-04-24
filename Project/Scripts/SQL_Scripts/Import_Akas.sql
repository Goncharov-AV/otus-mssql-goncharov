--IF (OBJECT_ID('tmpAkasCsv') IS NOT NULL) DROP TABLE tmp.tmpAkasCsv;
--
--CREATE TABLE tmp.tmpAkasCsv (
--	titleId	NVARCHAR(255),
--	ordering NVARCHAR(255),
--	title NVARCHAR(MAX),
--	region NVARCHAR(255),
--	language NVARCHAR(255),
--	types NVARCHAR(255),
--	attributes NVARCHAR(255),
--	isOriginalTitle NVARCHAR(255),
--)
--
--BULK INSERT tmp.tmpAkasCsv
--FROM 'c:\_Sources\otus-mssql-goncharov\Project\Datasets\IMDB\title.akas.tsv\data.tsv'
--WITH (fieldterminator = '	', rowterminator = '\n');

--BULK INSERT tmp.tmpAkasCsv
--	FROM "c:\_Sources\otus-mssql-goncharov\Project\Datasets\IMDB\title.akas.tsv\data.tsv"
--	WITH 
--		(
--		BATCHSIZE = 1000, 
--		DATAFILETYPE = 'widechar',
--		FIELDTERMINATOR = '\t',
--		ROWTERMINATOR ='\n',
--		CodePage = 65001,
--		KEEPNULLS,
--		TABLOCK        
--		);

INSERT  [AMDB].[tmp].[tmpAkas]([titleId]
      ,[ordering]
      ,[title]
      ,[region]
      ,[language]
      ,[types]
      ,[attributes]
      ,[isOriginalTitle])
 
SELECT [titleId]
      ,convert (int, [ordering])
      ,[title]
      ,[region]
      ,[language]
      ,[types]
      ,[attributes]
      ,[isOriginalTitle]
  FROM [AMDB].[tmp].[AkasCsv]