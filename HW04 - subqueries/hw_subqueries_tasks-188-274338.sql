/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.

Занятие "03 - Подзапросы, CTE, временные таблицы".

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
-- Для всех заданий, где возможно, сделайте два варианта запросов:
--  1) через вложенный запрос
--  2) через WITH (для производных таблиц)
-- ---------------------------------------------------------------------------

USE WideWorldImporters;

/*
1. Выберите сотрудников (Application.People), которые являются продажниками (IsSalesPerson), 
и не сделали ни одной продажи 04 июля 2015 года. 
Вывести ИД сотрудника и его полное имя. 
Продажи смотреть в таблице Sales.Invoices.
*/

WITH InvoicesJ AS 
(
	SELECT 
		SalespersonPersonID 
	FROM Sales.Invoices AS I
	WHERE I.InvoiceDate BETWEEN '2015-07-04 00:00:00' AND '2015-07-04 23:59:00'
)
SELECT 
	P.PersonID,
	P.FullName
FROM Application.People AS P
LEFT JOIN InvoicesJ AS I ON P.PersonID = I.SalespersonPersonID
WHERE P.IsSalesperson = 1 AND I.SalespersonPersonID IS NULL

SELECT 
	P.PersonID,
	P.FullName
FROM Application.People AS P
LEFT JOIN 
	(
		SELECT 
			SalespersonPersonID 
		FROM Sales.Invoices AS I
		WHERE I.InvoiceDate BETWEEN '2015-07-04 00:00:00' AND '2015-07-04 23:59:00'
	) AS I ON P.PersonID = I.SalespersonPersonID
WHERE P.IsSalesperson = 1 AND I.SalespersonPersonID IS NULL


/*
2. Выберите товары с минимальной ценой (подзапросом). Сделайте два варианта подзапроса. 
Вывести: ИД товара, наименование товара, цена.
*/

SELECT
	S.StockItemID,
	S.StockItemName,
	S.UnitPrice
FROM Warehouse.StockItems AS S
WHERE S.UnitPrice <= ALL (SELECT UnitPrice FROM Warehouse.StockItems I);

SELECT
	S.StockItemID,
	S.StockItemName,
	S.UnitPrice 
FROM Warehouse.StockItems AS S
WHERE S.UnitPrice = (SELECT MIN(UnitPrice) FROM Warehouse.StockItems I);

/*
3. Выберите информацию по клиентам, которые перевели компании пять максимальных платежей 
из Sales.CustomerTransactions. 
Представьте несколько способов (в том числе с CTE). 
*/

WITH CT AS
(
	SELECT TOP(5) 
		CustomerID
	FROM Sales.CustomerTransactions
	ORDER BY TransactionAmount DESC
)
SELECT 
	* 
FROM (SELECT DISTINCT CT.CustomerID FROM CT) AS UCT
JOIN Sales.Customers AS C ON C.CustomerID = UCT.CustomerID;

SELECT 
	C.*
FROM 
(
	SELECT DISTINCT 
		CT.CustomerID 
	FROM
	(
		SELECT TOP(5) 
		CustomerID
	FROM Sales.CustomerTransactions
	ORDER BY TransactionAmount DESC
	) AS CT
) AS UCT
JOIN Sales.Customers AS C ON C.CustomerID = UCT.CustomerID;

/*
4. Выберите города (ид и название), в которые были доставлены товары, 
входящие в тройку самых дорогих товаров, а также имя сотрудника, 
который осуществлял упаковку заказов (PackedByPersonID).
*/

WITH SI AS 
(
	SELECT TOP(3)
		StockItemID
	FROM Warehouse.StockItems
	ORDER BY UnitPrice DESC
)
SELECT
	CT.CityID,
	CT.CityName,
	P.FullName
FROM SI
JOIN Sales.OrderLines AS OL ON SI.StockItemID = OL.StockItemID
LEFT JOIN Sales.Orders AS O ON OL.OrderID = O.OrderID
LEFT JOIN Sales.Customers AS C ON O.CustomerID = C.CustomerID
LEFT JOIN Application.Cities AS CT ON C.DeliveryCityID = CT.CityID
LEFT JOIN Sales.Invoices AS I ON O.OrderID = I.OrderID
LEFT JOIN Application.People AS P ON I.PackedByPersonID = P.PersonID
ORDER BY CT.CityID;

SELECT
	SI.StockItemID,
	CT.CityID,
	CT.CityName,
	P.FullName
FROM 
(
	SELECT TOP(3)
		StockItemID
	FROM Warehouse.StockItems
	ORDER BY UnitPrice DESC
) AS SI
JOIN Sales.OrderLines AS OL ON SI.StockItemID = OL.StockItemID
LEFT JOIN Sales.Orders AS O ON OL.OrderID = O.OrderID
LEFT JOIN Sales.Customers AS C ON O.CustomerID = C.CustomerID
LEFT JOIN Application.Cities AS CT ON C.DeliveryCityID = CT.CityID
LEFT JOIN Sales.Invoices AS I ON O.OrderID = I.OrderID
LEFT JOIN Application.People AS P ON I.PackedByPersonID = P.PersonID
ORDER BY CT.CityID;

-- ---------------------------------------------------------------------------
-- Опциональное задание
-- ---------------------------------------------------------------------------
-- Можно двигаться как в сторону улучшения читабельности запроса, 
-- так и в сторону упрощения плана\ускорения. 
-- Сравнить производительность запросов можно через SET STATISTICS IO, TIME ON. 
-- Если знакомы с планами запросов, то используйте их (тогда к решению также приложите планы). 
-- Напишите ваши рассуждения по поводу оптимизации. 

-- 5. Объясните, что делает и оптимизируйте запрос

SELECT 
	Invoices.InvoiceID, 
	Invoices.InvoiceDate,
	(SELECT People.FullName
		FROM Application.People
		WHERE People.PersonID = Invoices.SalespersonPersonID
	) AS SalesPersonName,
	SalesTotals.TotalSumm AS TotalSummByInvoice, 
	(SELECT SUM(OrderLines.PickedQuantity*OrderLines.UnitPrice)
		FROM Sales.OrderLines
		WHERE OrderLines.OrderId = (SELECT Orders.OrderId 
			FROM Sales.Orders
			WHERE Orders.PickingCompletedWhen IS NOT NULL	
				AND Orders.OrderId = Invoices.OrderId)	
	) AS TotalSummForPickedItems
FROM Sales.Invoices 
	JOIN
	(SELECT InvoiceId, SUM(Quantity*UnitPrice) AS TotalSumm
	FROM Sales.InvoiceLines
	GROUP BY InvoiceId
	HAVING SUM(Quantity*UnitPrice) > 27000) AS SalesTotals
		ON Invoices.InvoiceID = SalesTotals.InvoiceID
ORDER BY TotalSumm DESC

-- --

--TODO: напишите здесь свое решение
-- Опциональные пропускаю до момента как нагоню группу
