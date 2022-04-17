-- ��������� �����������
USE master
GO
ALTER DATABASE WideWorldImporters SET SINGLE_USER WITH ROLLBACK IMMEDIATE

USE master
ALTER DATABASE WideWorldImporters
SET ENABLE_BROKER;	

ALTER DATABASE WideWorldImporters SET TRUSTWORTHY ON; 

ALTER AUTHORIZATION    
   ON DATABASE::WideWorldImporters TO [sa];

ALTER DATABASE WideWorldImporters SET MULTI_USER WITH ROLLBACK IMMEDIATE
GO

-- �������� ���������
USE WideWorldImporters
-- For Request
CREATE MESSAGE TYPE [//WWI/SB/MyRequestMessage] VALIDATION=WELL_FORMED_XML;
-- For Reply
CREATE MESSAGE TYPE [//WWI/SB/MyReplyMessage] VALIDATION=WELL_FORMED_XML; 
GO

-- �������� ���������
CREATE CONTRACT [//WWI/SB/MyContract]
      ([//WWI/SB/MyRequestMessage] SENT BY INITIATOR,
       [//WWI/SB/MyReplyMessage] SENT BY TARGET
      );
GO

-- �������� �������
CREATE QUEUE MyTargetQueueWWI;
CREATE QUEUE MyInitiatorQueueWWI;
-- DROP QUEUE MyTargetQueueWWI; DROP QUEUE MyInitiatorQueueWWI;
GO

-- �������� �������
CREATE SERVICE [//WWI/SB/MyTargetService] ON QUEUE MyTargetQueueWWI ([//WWI/SB/MyContract]);
GO

CREATE SERVICE [//WWI/SB/MyInitiatorService] ON QUEUE MyInitiatorQueueWWI ([//WWI/SB/MyContract]);
GO

-- DROP SERVICE [//WWI/SB/MyTargetService]; DROP SERVICE [//WWI/SB/MyInitiatorService]

-- �������� ��������� ��� �������� ��������
-- �������� ��������� ��� ����� ��������
-- �������� ��������� ��� �������������

-- ���������� ��������-������������
ALTER QUEUE [dbo].[MyInitiatorQueueWWI] WITH STATUS = ON , RETENTION = OFF , POISON_MESSAGE_HANDLING (STATUS = OFF) 
	, ACTIVATION (   STATUS = ON ,
        PROCEDURE_NAME = Sales.MyConfirmReport, MAX_QUEUE_READERS = 100, EXECUTE AS OWNER) ; 
GO

ALTER QUEUE [dbo].[MyTargetQueueWWI] WITH STATUS = ON , RETENTION = OFF , POISON_MESSAGE_HANDLING (STATUS = OFF)
	, ACTIVATION (  STATUS = ON ,
        PROCEDURE_NAME = Sales.MyGetNewReport, MAX_QUEUE_READERS = 100, EXECUTE AS OWNER) ; 
GO

-- ��������
EXEC Sales.MySendReportRequest @CustomerId = 112;
GO

SELECT * FROM Sales.MyClientReport
