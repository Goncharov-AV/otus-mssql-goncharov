/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.

Занятие "06 - Оконные функции".

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
1. Сделать расчет суммы продаж нарастающим итогом по месяцам с 2015 года 
(в рамках одного месяца он будет одинаковый, нарастать будет в течение времени выборки).
Выведите: id продажи, название клиента, дату продажи, сумму продажи, сумму нарастающим итогом

Пример:
-------------+----------------------------
Дата продажи | Нарастающий итог по месяцу
-------------+----------------------------
 2015-01-29   | 4801725.31
 2015-01-30	 | 4801725.31
 2015-01-31	 | 4801725.31
 2015-02-01	 | 9626342.98
 2015-02-02	 | 9626342.98
 2015-02-03	 | 9626342.98
Продажи можно взять из таблицы Invoices.
Нарастающий итог должен быть без оконной функции.
*/

set statistics time, io ON;

WITH MonthSum AS (
	SELECT
		DATEADD(month, DATEDIFF(month, 0, I.InvoiceDate), 0) AS [Month],
		SUM(L.UnitPrice * L.Quantity) AS [Sum]
	FROM Sales.Invoices I
	LEFT JOIN Sales.InvoiceLines AS L ON L.InvoiceID = I.InvoiceID
	GROUP BY DATEADD(month, DATEDIFF(month, 0, I.InvoiceDate), 0)
),
MonthSumRunning AS (
	SELECT
	[Month],
	(SELECT SUM(M2.[Sum]) FROM MonthSum M2 WHERE M2.[Month] <= M1.[Month]) [Sum]
	FROM MonthSum M1
)
SELECT
	I.InvoiceID,
	C.CustomerName,
	I.InvoiceDate,
	SUM(L.UnitPrice * L.Quantity) AS [Sum],
	(SELECT [Sum] FROM MonthSumRunning MS WHERE DATEADD(month, DATEDIFF(month, 0, I.InvoiceDate), 0) = MS.Month) AS [Sum]
FROM Sales.Invoices AS I
LEFT JOIN Sales.InvoiceLines AS L ON L.InvoiceID = I.InvoiceID
LEFT JOIN Sales.Customers AS C ON C.CustomerID = I.CustomerID
GROUP BY I.InvoiceID,	C.CustomerName,	I.InvoiceDate
ORDER BY I.InvoiceDate, I.InvoiceID;

set statistics time, io OFF;
/*
2. Сделайте расчет суммы нарастающим итогом в предыдущем запросе с помощью оконной функции.
   Сравните производительность запросов 1 и 2 с помощью set statistics time, io on
*/
set statistics time, io ON;

SELECT
	I.InvoiceID,
	C.CustomerName,
	I.InvoiceDate,
	SUM(L.UnitPrice * L.Quantity) AS [Sum],
	SUM (SUM(L.UnitPrice * L.Quantity)) OVER (ORDER BY DATEADD(month, DATEDIFF(month, 0, I.InvoiceDate), 0)) AS [MonthSumRunning]
FROM Sales.Invoices AS I
LEFT JOIN Sales.InvoiceLines AS L ON L.InvoiceID = I.InvoiceID
LEFT JOIN Sales.Customers AS C ON C.CustomerID = I.CustomerID
GROUP BY I.InvoiceID,	C.CustomerName,	I.InvoiceDate
ORDER BY I.InvoiceDate, I.InvoiceID;

set statistics time, io OFF;
/*
3. Вывести список 2х самых популярных продуктов (по количеству проданных) 
в каждом месяце за 2016 год (по 2 самых популярных продукта в каждом месяце).
*/

WITH Sums AS (
	SELECT
		DATEADD(month, DATEDIFF(month, 0, I.InvoiceDate), 0) AS [Month],
		IL.StockItemId,
		SUM(IL.Quantity) QuantitySum
	FROM Sales.Invoices AS I
	LEFT JOIN Sales.InvoiceLines AS IL ON I.InvoiceID = IL.InvoiceID
	GROUP BY IL.StockItemID, DATEADD(month, DATEDIFF(month, 0, I.InvoiceDate), 0)
),
RangedSums AS (
	SELECT
		S.[Month],
		S.StockItemID,
		S.QuantitySum,
		ROW_NUMBER() OVER (PARTITION BY S.[Month] ORDER BY S.QuantitySum DESC) AS RN
	FROM Sums AS S
)
SELECT
	RS.[Month],
	SI.StockItemName,
	RS.StockItemID,
	RS.QuantitySum
FROM RangedSums AS RS
LEFT JOIN Warehouse.StockItems AS SI ON RS.StockItemID = SI.StockItemID
WHERE RS.RN <= 2

/*
4. Функции одним запросом
Посчитайте по таблице товаров (в вывод также должен попасть ид товара, название, брэнд и цена):
* пронумеруйте записи по названию товара, так чтобы при изменении буквы алфавита нумерация начиналась заново
* посчитайте общее количество товаров и выведете полем в этом же запросе
* посчитайте общее количество товаров в зависимости от первой буквы названия товара
* отобразите следующий id товара исходя из того, что порядок отображения товаров по имени 
* предыдущий ид товара с тем же порядком отображения (по имени)
* названия товара 2 строки назад, в случае если предыдущей строки нет нужно вывести "No items"
* сформируйте 30 групп товаров по полю вес товара на 1 шт

Для этой задачи НЕ нужно писать аналог без аналитических функций.
*/

SELECT 
	S.StockItemID,
	S.StockItemName,
	S.Brand,
	S.UnitPrice,
	ROW_NUMBER() OVER (PARTITION BY LEFT(S.StockItemName,1) ORDER BY S.StockItemName) AS NumberInFirstLetter,
	COUNT(S.StockItemID) OVER () AS Quantity,
	COUNT(S.StockItemID) OVER (PARTITION BY LEFT(S.StockItemName,1)) AS QuantityByLetter,
	LEAD(S.StockItemName) OVER (ORDER BY S.StockItemName) AS [Next],
	LAG(S.StockItemName) OVER (ORDER BY S.StockItemName) AS [Prev],
	ISNULL(LAG(S.StockItemName,2) OVER (ORDER BY S.StockItemName),'No items') AS [TwoPositionsPrev],
	S.TypicalWeightPerUnit,
	W.[Max] MaxWeight,
	AVG(S.TypicalWeightPerUnit) OVER (PARTITION BY S.TypicalWeightPerUnit/W.[Max]/30) AS AverageWeightInGroup
FROM Warehouse.StockItems AS S
JOIN (SELECT MAX(TypicalWeightPerUnit) AS [Max] FROM Warehouse.StockItems) AS W ON S.StockItemID = S.StockItemID
ORDER BY S.StockItemName

/*
5. По каждому сотруднику выведите последнего клиента, которому сотрудник что-то продал.
   В результатах должны быть ид и фамилия сотрудника, ид и название клиента, дата продажи, сумму сделки.
*/

SELECT 
	PersonID,
	FullName,
	CustomerID,
	CustomerName,
	[Sum]
FROM (
	SELECT 
		P.PersonID,
		P.FullName,
		C.CustomerID,
		C.CustomerName,
		Sums.[Sum],
		ROW_NUMBER() OVER (PARTITION BY I.SalespersonPersonID ORDER BY Sums.[Sum] DESC) AS RN
	FROM Application.People AS P
	LEFT JOIN Sales.Invoices AS I ON P.PersonID = I.SalespersonPersonID
	LEFT JOIN Sales.Customers AS C ON I.CustomerID = C.CustomerID
	LEFT JOIN (
		SELECT
			InvoiceID,
			SUM(UnitPrice * Quantity) AS [Sum]
		FROM Sales.InvoiceLines
		GROUP BY InvoiceID
	) AS Sums ON I.InvoiceID = Sums.InvoiceID
	WHERE P.IsSalesperson = 1
) AS SQ
WHERE RN = 1

/*
6. Выберите по каждому клиенту два самых дорогих товара, которые он покупал.
В результатах должно быть ид клиета, его название, ид товара, цена, дата покупки.
*/

SELECT
	CustomerID,
	CustomerName,
	StockItemID,
	UnitPrice,
	InvoiceDate
FROM
(
	SELECT
		C.CustomerID,
		C.CustomerName,
		L.StockItemID,
		L.UnitPrice,
		I.InvoiceDate,
		ROW_NUMBER() OVER (PARTITION BY C.CustomerID ORDER BY L.UnitPrice DESC) AS RN
	FROM Sales.Customers AS C
	LEFT JOIN Sales.Invoices AS I ON C.CustomerID = I.CustomerID
	LEFT JOIN Sales.InvoiceLines AS L ON I.InvoiceID = L.InvoiceID
) AS Q
WHERE RN <=2

--Опционально можете для каждого запроса без оконных функций сделать вариант запросов с оконными функциями и сравнить их производительность. 