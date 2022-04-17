USE [WideWorldImporters]

DROP PROCEDURE IF EXISTS Sales.MySendReportRequest;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Sales.MySendReportRequest
	@CustomerId INT
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @InitDlgHandle UNIQUEIDENTIFIER;
	DECLARE @RequestMessage NVARCHAR(4000);
	
	BEGIN TRAN

	SELECT @RequestMessage = (SELECT Cust.CustomerID
							  FROM Sales.Customers AS Cust
							  WHERE CustomerID = @CustomerId
							  FOR XML AUTO, ROOT('RequestMessage')); 
	
	BEGIN DIALOG @InitDlgHandle
	FROM SERVICE
	[//WWI/SB/MyInitiatorService]
	TO SERVICE
	'//WWI/SB/MyTargetService'
	ON CONTRACT
	[//WWI/SB/MyContract]
	WITH ENCRYPTION=OFF; 

	SEND ON CONVERSATION @InitDlgHandle 
	MESSAGE TYPE
	[//WWI/SB/MyRequestMessage]
	(@RequestMessage);
	SELECT @RequestMessage AS SentRequestMessage;
	COMMIT TRAN 
END
GO
