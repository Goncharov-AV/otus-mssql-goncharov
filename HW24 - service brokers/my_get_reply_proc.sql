USE [WideWorldImporters]

DROP PROCEDURE IF EXISTS Sales.MyConfirmReport;
GO

CREATE PROCEDURE Sales.MyConfirmReport
AS
BEGIN
	DECLARE @InitiatorReplyDlgHandle UNIQUEIDENTIFIER,
			@ReplyReceivedMessage NVARCHAR(1000) 
	
	BEGIN TRAN; 

		RECEIVE TOP(1)
			@InitiatorReplyDlgHandle=Conversation_Handle
			,@ReplyReceivedMessage=Message_Body
		FROM dbo.MyInitiatorQueueWWI; 
		
		END CONVERSATION @InitiatorReplyDlgHandle;

		SELECT @ReplyReceivedMessage AS ReceivedRepliedMessage;

	COMMIT TRAN; 
END


