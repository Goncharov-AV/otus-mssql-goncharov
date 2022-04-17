use WideWorldImporters;

SELECT COUNT(*)
FROM Sales.Orders
WHERE CustomerId = 111;

--Send message
EXEC Sales.MySendReportRequest @CustomerId = 111

--� ����� ������� �������� ���������?
SELECT CAST(message_body AS XML),*
FROM dbo.MyInitiatorQueueWWI;

SELECT CAST(message_body AS XML),*
FROM dbo.MyTargetQueueWWI;

--�������� �������, ��� ��� ��������
--Target
EXEC Sales.MyGetNewReport;

--Initiator
EXEC Sales.MyConfirmReport;

SELECT * FROM Sales.MyClientReport
