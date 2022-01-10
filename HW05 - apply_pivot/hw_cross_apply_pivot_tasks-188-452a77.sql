/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.

Занятие "05 - Операторы CROSS APPLY, PIVOT, UNPIVOT".

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
1. Требуется написать запрос, который в результате своего выполнения 
формирует сводку по количеству покупок в разрезе клиентов и месяцев.
В строках должны быть месяцы (дата начала месяца), в столбцах - клиенты.

Клиентов взять с ID 2-6, это все подразделение Tailspin Toys.
Имя клиента нужно поменять так чтобы осталось только уточнение.
Например, исходное значение "Tailspin Toys (Gasport, NY)" - вы выводите только "Gasport, NY".
Дата должна иметь формат dd.mm.yyyy, например, 25.12.2019.

Пример, как должны выглядеть результаты:
-------------+--------------------+--------------------+-------------+--------------+------------
InvoiceMonth | Peeples Valley, AZ | Medicine Lodge, KS | Gasport, NY | Sylvanite, MT | Jessie, ND
-------------+--------------------+--------------------+-------------+--------------+------------
01.01.2013   |      3             |        1           |      4      |      2        |     2
01.02.2013   |      7             |        3           |      4      |      2        |     1
-------------+--------------------+--------------------+-------------+--------------+------------
*/

WITH PivotData AS
(
	SELECT 
		C.CustomerID,
		CAST (DATEADD(month, DATEDIFF(month, 0, O.OrderDate), 0) AS DATE) [Month]
	FROM Sales.Customers AS C
	LEFT JOIN Sales.Orders AS O ON C.CustomerID = O.CustomerID
	WHERE C.CustomerID BETWEEN 2 AND 6
)
SELECT
	PivotTable.Month,
	PivotTable.[2] AS [Sylvanite, MT],
	PivotTable.[3] AS [Peeples Valley, AZ],
	PivotTable.[4] AS [Medicine Lodge, KS],
	PivotTable.[5] AS [Gasport, NY],
	PivotTable.[6] AS [Jessie, ND]
FROM PivotData
PIVOT (COUNT(CustomerID) FOR CustomerID IN ([2],[3],[4],[5],[6])) AS PivotTable
;

/*
2. Для всех клиентов с именем, в котором есть "Tailspin Toys"
вывести все адреса, которые есть в таблице, в одной колонке.

Пример результата:
----------------------------+--------------------
CustomerName                | AddressLine
----------------------------+--------------------
Tailspin Toys (Head Office) | Shop 38
Tailspin Toys (Head Office) | 1877 Mittal Road
Tailspin Toys (Head Office) | PO Box 8975
Tailspin Toys (Head Office) | Ribeiroville
----------------------------+--------------------
*/

SELECT 
	CustomerName,
	[Address]
FROM 
	(
		SELECT
			CustomerName,
			DeliveryAddressLine1,
			DeliveryAddressLine2,
			PostalAddressLine1,
			PostalAddressLine2
		FROM Sales.Customers 
		WHERE CustomerName LIKE '%Tailspin Toys%'
	) AS PVT
UNPIVOT ([Address] FOR Addr IN(DeliveryAddressLine1,DeliveryAddressLine2,PostalAddressLine1,PostalAddressLine2)) AS upvt;

/*
3. В таблице стран (Application.Countries) есть поля с цифровым кодом страны и с буквенным.
Сделайте выборку ИД страны, названия и ее кода так, 
чтобы в поле с кодом был либо цифровой либо буквенный код.

Пример результата:
--------------------------------
CountryId | CountryName | Code
----------+-------------+-------
1         | Afghanistan | AFG
1         | Afghanistan | 4
3         | Albania     | ALB
3         | Albania     | 8
----------+-------------+-------
*/

SELECT 
	C.CountryName,
	A.Code
FROM Application.Countries AS C
CROSS APPLY 
(	
	SELECT
		unpt.CountryName,
		unpt.Code
	FROM
	(
		SELECT
			A.CountryName,
			A.IsoAlpha3Code,
			CAST(A.IsoNumericCode AS NVARCHAR(3)) AS IsoNumericCode
		FROM Application.Countries A
		WHERE C.CountryName = A.CountryName
	) AS CTR 
	UNPIVOT (Code FOR CodeType IN(IsoAlpha3Code, IsoNumericCode)) AS unpt
) AS A;

/*
SELECT 
	C.CountryName,
	A.Code
FROM Application.Countries AS C
CROSS APPLY 
(	
	SELECT
		A.IsoAlpha3Code AS Code
	FROM Application.Countries A
	WHERE C.CountryID = A.CountryID
	UNION
	SELECT
		CAST(B.IsoNumericCode AS NVARCHAR(max))
	FROM Application.Countries B
	WHERE C.CountryID = B.CountryID
) AS A
*/

/*
4. Выберите по каждому клиенту два самых дорогих товара, которые он покупал.
В результатах должно быть ид клиета, его название, ид товара, цена, дата покупки.
*/

-- Насколько понимаю уточнения что 2 разных в условии нет
SELECT
	C.CustomerID,
	C.CustomerName,
	T.StockItemID,
	T.UnitPrice,
	T.OrderDate
FROM Sales.Customers AS C
CROSS APPLY (
	SELECT TOP(2)
		L.StockItemID,
		L.UnitPrice,
		O.OrderDate
	FROM Sales.Orders AS O
	LEFT JOIN Sales.OrderLines AS L ON O.OrderID = L.OrderID
	WHERE C.CustomerID = O.CustomerID
	ORDER BY L.UnitPrice DESC
) AS T;
