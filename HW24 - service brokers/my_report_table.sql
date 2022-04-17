USE [WideWorldImporters]

CREATE TABLE Sales.MyClientReport (
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY ,
	[CustomerId] INT NOT NULL,
	[OrderCount] INT NOT NULL
)

-- DROP TABLE Sales.MyClientReport
