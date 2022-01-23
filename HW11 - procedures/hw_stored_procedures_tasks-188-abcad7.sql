/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.

Занятие "12 - Хранимые процедуры, функции, триггеры, курсоры".

Задания выполняются с использованием базы данных WideWorldImporters.

Бэкап БД можно скачать отсюда:
https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0
Нужен WideWorldImporters-Full.bak

Описание WideWorldImporters от Microsoft:
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-what-is
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-oltp-database-catalog
*/

USE WideWorldImporters;

/*
Во всех заданиях написать хранимую процедуру / функцию и продемонстрировать ее использование.
*/

/*
1) Написать функцию возвращающую Клиента с наибольшей суммой покупки.
*/
GO;

IF OBJECT_ID ( 'Sales.CustomerWithMaxSum', 'FN' ) IS NOT NULL   
    DROP FUNCTION Sales.CustomerWithMaxSum; 
GO;

CREATE FUNCTION Sales.CustomerWithMaxSum()
RETURNS int
AS
BEGIN
	RETURN 
	(
		SELECT TOP(1)
			C.CustomerID
		FROM Sales.Customers AS C
		JOIN Sales.Invoices AS I ON I.CustomerID = C.CustomerID
		JOIN Sales.InvoiceLines AS L ON L.InvoiceID = I.InvoiceID
		GROUP BY C.CustomerID
		ORDER BY SUM(L.Quantity * L.UnitPrice) DESC
	)
END;
GO;

SELECT Sales.CustomerWithMaxSum() AS [Customer with max invoice sum];
GO;
/*
2) Написать хранимую процедуру с входящим параметром СustomerID, выводящую сумму покупки по этому клиенту.
Использовать таблицы :
Sales.Customers
Sales.Invoices
Sales.InvoiceLines
*/

IF OBJECT_ID ( 'Sales.GetSumByCustomerId', 'FN' ) IS NOT NULL   
    DROP FUNCTION Sales.GetSumByCustomerId; 
GO;

CREATE FUNCTION Sales.GetSumByCustomerId
(
	@custId INT
)
RETURNS DECIMAL(18,2)
AS
BEGIN
	RETURN 
	(
		SELECT TOP(1)
			SUM(L.Quantity * L.UnitPrice)
		FROM Sales.Customers AS C
		JOIN Sales.Invoices AS I ON I.CustomerID = C.CustomerID
		JOIN Sales.InvoiceLines AS L ON L.InvoiceID = I.InvoiceID
		WHERE C.CustomerID = @custId
		GROUP BY C.CustomerID
	)
END;
GO;

SELECT C.CustomerID, C.CustomerName, Sales.GetSumByCustomerId(C.CustomerID) AS [Sum by Customer ID] FROM Sales.Customers AS C;
GO;

/*
3) Создать одинаковую функцию и хранимую процедуру, посмотреть в чем разница в производительности и почему.
*/
IF OBJECT_ID ( 'Sales.GetSumsByPattern', 'IF' ) IS NOT NULL   
    DROP FUNCTION Sales.GetSumsByPattern; 
GO

CREATE FUNCTION Sales.GetSumsByPattern
(
	@pattern varchar(50)
)
RETURNS TABLE
AS
RETURN 
(
	SELECT
		MAX(C.CustomerName) AS CustomerName,
		SUM(L.Quantity * L.UnitPrice) AS [Sum]
	FROM Sales.Customers AS C
	JOIN Sales.Invoices AS I ON I.CustomerID = C.CustomerID
	JOIN Sales.InvoiceLines AS L ON L.InvoiceID = I.InvoiceID
	WHERE C.CustomerName LIKE CONCAT(@pattern, '%')
	GROUP BY C.CustomerID
);
GO

IF OBJECT_ID ( 'Sales.GetSumsByPatternP', 'P' ) IS NOT NULL   
    DROP PROCEDURE Sales.GetSumsByPatternP; 
GO

CREATE PROCEDURE Sales.GetSumsByPatternP
(
	@pattern varchar(50)
)
AS
BEGIN
		SELECT
			MAX(C.CustomerName) AS CustomerName,
			SUM(L.Quantity * L.UnitPrice) AS [Sum]
		FROM Sales.Customers AS C
		JOIN Sales.Invoices AS I ON I.CustomerID = C.CustomerID
		JOIN Sales.InvoiceLines AS L ON L.InvoiceID = I.InvoiceID
		WHERE C.CustomerName LIKE CONCAT(@pattern, '%')
		GROUP BY C.CustomerID;
END;
GO

SET STATISTICS time, io ON;
SELECT * FROM Sales.GetSumsByPattern('La');
EXECUTE Sales.GetSumsByPatternP @pattern = 'La';
SET STATISTICS time, io OFF;

/*
4) Создайте табличную функцию покажите как ее можно вызвать для каждой строки result set'а без использования цикла. 
*/

EXEC ('SELECT CustomerID,CustomerName,CustomerCategoryID FROM Sales.Customers WHERE CustomerCategoryID = 3')
WITH RESULT SETS
((
	[identity] int,
	[name] nvarchar(50),
	[category] int
))

/*
5) Опционально. Во всех процедурах укажите какой уровень изоляции транзакций вы бы использовали и почему. 
*/
