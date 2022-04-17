USE [WideWorldImporters]

DROP PROCEDURE IF EXISTS Sales.MyGetNewReport;
GO

CREATE OR ALTER PROCEDURE Sales.MyGetNewReport
AS
BEGIN

	DECLARE @TargetDlgHandle UNIQUEIDENTIFIER,
			@Message NVARCHAR(4000),
			@MessageType Sysname,
			@ReplyMessage NVARCHAR(4000),
			@CustomerID INT,
			@OrderCount INT,
			@xml XML; 
	
	BEGIN TRAN; 

	RECEIVE TOP(1)
		@TargetDlgHandle = Conversation_Handle,
		@Message = Message_Body,
		@MessageType = Message_Type_Name
	FROM dbo.MyTargetQueueWWI; 

	SELECT @Message;

	SET @xml = CAST(@Message AS XML);

	SELECT @CustomerID = R.Iv.value('@CustomerID','INT')
	FROM @xml.nodes('/RequestMessage/Cust') as R(Iv);

	IF EXISTS (SELECT * FROM Sales.Customers WHERE CustomerID = @CustomerID)
	BEGIN
		SET @OrderCount = (SELECT COUNT(*) FROM Sales.Orders WHERE CustomerId = @CustomerID)
		INSERT Sales.MyClientReport([CustomerId],[OrderCount])
		VALUES (@CustomerID,@OrderCount)
	END;

	SELECT @CustomerID
	SELECT @OrderCount
	
	SELECT @Message AS ReceivedRequestMessage, @MessageType;
	
	IF @MessageType=N'//WWI/SB/MyRequestMessage'
	BEGIN
		SET @ReplyMessage =N'<ReplyMessage> Message received </ReplyMessage>'; 
	
		SEND ON CONVERSATION @TargetDlgHandle
		MESSAGE TYPE
		[//WWI/SB/MyReplyMessage]
		(@ReplyMessage);
		END CONVERSATION @TargetDlgHandle;
	END 
	
	SELECT @ReplyMessage AS SentReplyMessage;

	COMMIT TRAN;
END