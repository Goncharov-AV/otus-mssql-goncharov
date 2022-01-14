/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.

Занятие "10 - Операторы изменения данных".

Задания выполняются с использованием базы данных WideWorldImporters.

Бэкап БД можно скачать отсюда:
https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0
Нужен WideWorldImporters-Full.bak

Описание WideWorldImporters от Microsoft:
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-what-is
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-oltp-database-catalog
*/

-- ---------------------------------------------------------------------------
-- Задание - написать выборки для получения указанных ниже данных.
-- ---------------------------------------------------------------------------

USE WideWorldImporters;

/*
1. Довставлять в базу пять записей используя insert в таблицу Customers или Suppliers 
*/

INSERT INTO Sales.Customers
(
    CustomerID,
    CustomerName,
    BillToCustomerID,
    CustomerCategoryID,
    BuyingGroupID,
    PrimaryContactPersonID,
    AlternateContactPersonID,
    DeliveryMethodID,
    DeliveryCityID,
    PostalCityID,
    CreditLimit,
    AccountOpenedDate,
    StandardDiscountPercentage,
    IsStatementSent,
    IsOnCreditHold,
    PaymentDays,
    PhoneNumber,
    FaxNumber,
    DeliveryRun,
    RunPosition,
    WebsiteURL,
    DeliveryAddressLine1,
    DeliveryAddressLine2,
    DeliveryPostalCode,
    DeliveryLocation,
    PostalAddressLine1,
    PostalAddressLine2,
    PostalPostalCode,
    LastEditedBy
)
VALUES
(   NEXT VALUE FOR Sequences.CustomerID, 
    N'Test Customer #2',
    1,
    1,
    NULL,
    1,
    NULL,
    1,
    1,
    1,
    NULL,
    GETDATE(),
    10,
    1,
    1,
    10,
    N'+7 900',
    N'+7 900',
    NULL,
    NULL,
    N'www.ya.ru',
    N'Lenina st. #11',
    NULL,
    N'123123',
    NULL,
    N'',
    NULL,
    N'',
    10
),
(   NEXT VALUE FOR Sequences.CustomerID, N'Test Customer #3',1,1,NULL,1,NULL,1,1,1,NULL,GETDATE(),10,1,1,10,N'+7 900',N'+7 900',NULL,NULL,N'www.ya.ru',N'Lenina st. #11',
	NULL,N'123123',NULL,N'',NULL,N'',10),
(   NEXT VALUE FOR Sequences.CustomerID, N'Test Customer #4',1,1,NULL,1,NULL,1,1,1,NULL,GETDATE(),10,1,1,10,N'+7 900',N'+7 900',NULL,NULL,N'www.ya.ru',N'Lenina st. #11',
	NULL,N'123123',NULL,N'',NULL,N'',10),
(   NEXT VALUE FOR Sequences.CustomerID, N'Test Customer #5',1,1,NULL,1,NULL,1,1,1,NULL,GETDATE(),10,1,1,10,N'+7 900',N'+7 900',NULL,NULL,N'www.ya.ru',N'Lenina st. #11',
	NULL,N'123123',NULL,N'',NULL,N'',10),
(   NEXT VALUE FOR Sequences.CustomerID, N'Test Customer #6',1,1,NULL,1,NULL,1,1,1,NULL,GETDATE(),10,1,1,10,N'+7 900',N'+7 900',NULL,NULL,N'www.ya.ru',N'Lenina st. #11',
	NULL,N'123123',NULL,N'',NULL,N'',10)

/*
2. Удалите одну запись из Customers, которая была вами добавлена
*/

DELETE FROM Sales.Customers WHERE CustomerName = N'Test Customer #1'

/*
3. Изменить одну запись, из добавленных через UPDATE
*/

UPDATE Sales.Customers 
SET CustomerName = N'Oleg'
WHERE CustomerName = N'Test Customer #2'

/*
4. Написать MERGE, который вставит вставит запись в клиенты, если ее там нет, и изменит если она уже есть
*/

SELECT TOP(10) * INTO Sales.CustomersTMP FROM Sales.Customers ORDER BY CustomerID
SELECT * FROM Sales.CustomersTMP1 -- Target

INSERT INTO Sales.CustomersTMP1
(
    CustomerID,
    CustomerName,
    BillToCustomerID,
    CustomerCategoryID,
    BuyingGroupID,
    PrimaryContactPersonID,
    AlternateContactPersonID,
    DeliveryMethodID,
    DeliveryCityID,
    PostalCityID,
    CreditLimit,
    AccountOpenedDate,
    StandardDiscountPercentage,
    IsStatementSent,
    IsOnCreditHold,
    PaymentDays,
    PhoneNumber,
    FaxNumber,
    DeliveryRun,
    RunPosition,
    WebsiteURL,
    DeliveryAddressLine1,
    DeliveryAddressLine2,
    DeliveryPostalCode,
    DeliveryLocation,
    PostalAddressLine1,
    PostalAddressLine2,
    PostalPostalCode,
    LastEditedBy,
	ValidFrom,
	ValidTo
)
VALUES
(1066,N'Test Customer #2',1,1,NULL,1,NULL,1,1,1,NULL,GETDATE(),10,1,1,10,N'+7 900',N'+7 900',NULL,NULL,N'www.ya.ru',N'Lenina st. #11',NULL,N'123123',NULL,N'',NULL,N'',10,GETDATE(),GETDATE())

MERGE Sales.CustomersTMP1 AS target
USING (SELECT * FROM Sales.Customers) AS source(CustomerID,CustomerName,BillToCustomerID,CustomerCategoryID,BuyingGroupID,PrimaryContactPersonID,AlternateContactPersonID,DeliveryMethodID,DeliveryCityID,PostalCityID,CreditLimit,AccountOpenedDate,StandardDiscountPercentage,IsStatementSent,IsOnCreditHold,PaymentDays,PhoneNumber,FaxNumber,DeliveryRun,RunPosition,WebsiteURL,DeliveryAddressLine1,DeliveryAddressLine2,DeliveryPostalCode,DeliveryLocation,PostalAddressLine1,PostalAddressLine2,PostalPostalCode,LastEditedBy,ValidFrom,ValidTo) ON target.CustomerID = source.CustomerID
WHEN MATCHED
	THEN UPDATE SET
		CustomerID = source.CustomerID,
		CustomerName = source.CustomerName,
		BillToCustomerID = source.BillToCustomerID,
		CustomerCategoryID = source.CustomerCategoryID,
		BuyingGroupID = source.BuyingGroupID,
		PrimaryContactPersonID = source.PrimaryContactPersonID,
		AlternateContactPersonID = source.AlternateContactPersonID,
		DeliveryMethodID = source.DeliveryMethodID,
		DeliveryCityID = source.DeliveryCityID,
		PostalCityID = source.PostalCityID,
		CreditLimit = source.CreditLimit,
		AccountOpenedDate = source.AccountOpenedDate,
		StandardDiscountPercentage = source.StandardDiscountPercentage,
		IsStatementSent = source.IsStatementSent,
		IsOnCreditHold = source.IsOnCreditHold,
		PaymentDays = source.PaymentDays,
		PhoneNumber = source.PhoneNumber,
		FaxNumber = source.FaxNumber,
		DeliveryRun = source.DeliveryRun,
		RunPosition = source.RunPosition,
		WebsiteURL = source.WebsiteURL,
		DeliveryAddressLine1 = source.DeliveryAddressLine1,
		DeliveryAddressLine2 = source.DeliveryAddressLine2,
		DeliveryPostalCode = source.DeliveryPostalCode,
		DeliveryLocation = source.DeliveryLocation,
		PostalAddressLine1 = source.PostalAddressLine1,
		PostalAddressLine2 = source.PostalAddressLine2,
		PostalPostalCode = source.PostalPostalCode,
		LastEditedBy = source.LastEditedBy,
		ValidFrom = source.ValidFrom,
		ValidTo = source.ValidTo
WHEN NOT MATCHED
	THEN INSERT (CustomerID,CustomerName,BillToCustomerID,CustomerCategoryID,BuyingGroupID,PrimaryContactPersonID,AlternateContactPersonID,DeliveryMethodID,DeliveryCityID,PostalCityID,CreditLimit,AccountOpenedDate,StandardDiscountPercentage,IsStatementSent,IsOnCreditHold,PaymentDays,PhoneNumber,FaxNumber,DeliveryRun,RunPosition,WebsiteURL,DeliveryAddressLine1,DeliveryAddressLine2,DeliveryPostalCode,DeliveryLocation,PostalAddressLine1,PostalAddressLine2,PostalPostalCode,LastEditedBy,ValidFrom,ValidTo)
		VALUES(source.CustomerID,source.CustomerName,source.BillToCustomerID,source.CustomerCategoryID,source.BuyingGroupID,source.PrimaryContactPersonID,source.AlternateContactPersonID,source.DeliveryMethodID,source.DeliveryCityID,source.PostalCityID,source.CreditLimit,source.AccountOpenedDate,source.StandardDiscountPercentage,source.IsStatementSent,source.IsOnCreditHold,source.PaymentDays,source.PhoneNumber,source.FaxNumber,source.DeliveryRun,source.RunPosition,source.WebsiteURL,source.DeliveryAddressLine1,source.DeliveryAddressLine2,source.DeliveryPostalCode,source.DeliveryLocation,source.PostalAddressLine1,source.PostalAddressLine2,source.PostalPostalCode,source.LastEditedBy,source.ValidFrom,source.ValidTo)
OUTPUT deleted.*, $action, inserted.*;

/*
5. Напишите запрос, который выгрузит данные через bcp out и загрузить через bulk insert
*/

EXEC master..xp_cmdshell 'bcp "WideWorldImporters.Sales.Customers" out "C:\_Temp\Customers.txt" -T -w -t"@eu&$1&" -S EMI-N-ET410002'

SELECT TOP(0) * INTO Sales.CustormersTMP FROM Sales.Customers 

BULK INSERT WideWorldImporters.Sales.CustormersTMP
	FROM "C:\_Temp\Customers.txt"
	WITH 
		(
		BATCHSIZE = 1000, 
		DATAFILETYPE = 'widechar',
		FIELDTERMINATOR = '@eu&$1&',
		ROWTERMINATOR ='\n',
		KEEPNULLS,
		TABLOCK        
		);

SELECT * FROM Sales.CustormersTMP