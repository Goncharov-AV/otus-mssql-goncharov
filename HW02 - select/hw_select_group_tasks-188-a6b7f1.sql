/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.
Занятие "02 - Оператор SELECT и простые фильтры, GROUP BY, HAVING".

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

USE WideWorldImporters

/*
1. Все товары, в названии которых есть "urgent" или название начинается с "Animal".
Вывести: ИД товара (StockItemID), наименование товара (StockItemName).
Таблицы: Warehouse.StockItems.
*/

SELECT 
	StockItemID,
	StockItemName
FROM Warehouse.StockItems
WHERE StockItemName LIKE N'%urgent%' OR StockItemName LIKE N'Animal%';

/*
2. Поставщиков (Suppliers), у которых не было сделано ни одного заказа (PurchaseOrders).
Сделать через JOIN, с подзапросом задание принято не будет.
Вывести: ИД поставщика (SupplierID), наименование поставщика (SupplierName).
Таблицы: Purchasing.Suppliers, Purchasing.PurchaseOrders.
По каким колонкам делать JOIN подумайте самостоятельно.
*/

SELECT
	S.SupplierID,
	S.SupplierName
FROM Purchasing.Suppliers AS S
LEFT JOIN Purchasing.PurchaseOrders AS O ON S.SupplierID = O.SupplierID
WHERE O.PurchaseOrderID IS NULL;

/*
3. Заказы (Orders) с ценой товара (UnitPrice) более 100$ 
либо количеством единиц (Quantity) товара более 20 штук
и присутствующей датой комплектации всего заказа (PickingCompletedWhen).
Вывести:
* OrderID
* дату заказа (OrderDate) в формате ДД.ММ.ГГГГ
* название месяца, в котором был сделан заказ
* номер квартала, в котором был сделан заказ
* треть года, к которой относится дата заказа (каждая треть по 4 месяца)
* имя заказчика (Customer)
Добавьте вариант этого запроса с постраничной выборкой,
пропустив первую 1000 и отобразив следующие 100 записей.

Сортировка должна быть по номеру квартала, трети года, дате заказа (везде по возрастанию).

Таблицы: Sales.Orders, Sales.OrderLines, Sales.Customers.
*/

SELECT
	O.OrderID,
	CONVERT(VARCHAR(10), O.OrderDate, 104) AS [Date],
	DateName( month , DateAdd( month , MONTH(O.OrderDate) , -1 )) AS [Month],
	(MONTH(O.OrderDate) - 1) / 3  + 1 AS [Quarter],
	(MONTH(O.OrderDate) - 1) / 4  + 1 AS [Third],
	C.CustomerName
FROM Sales.Orders AS O
LEFT JOIN Sales.OrderLines AS L ON O.OrderID = L.OrderID
LEFT JOIN Sales.Customers AS C ON O.CustomerID = C.CustomerID
WHERE
	(L.UnitPrice > 100 OR L.Quantity > 20) AND L.PickingCompletedWhen IS NOT NULL
ORDER BY ((MONTH(O.OrderDate) - 1) / 3  + 1), (MONTH(O.OrderDate) - 1) / 4  + 1, O.	OrderID
OFFSET 1000 ROWS FETCH NEXT 100 ROWS ONLY;

/*
4. Заказы поставщикам (Purchasing.Suppliers),
которые должны быть исполнены (ExpectedDeliveryDate) в январе 2013 года
с доставкой "Air Freight" или "Refrigerated Air Freight" (DeliveryMethodName)
и которые исполнены (IsOrderFinalized).
Вывести:
* способ доставки (DeliveryMethodName)
* дата доставки (ExpectedDeliveryDate)
* имя поставщика
* имя контактного лица принимавшего заказ (ContactPerson)

Таблицы: Purchasing.Suppliers, Purchasing.PurchaseOrders, Application.DeliveryMethods, Application.People.
*/

SELECT 
	D.DeliveryMethodName,
	O.ExpectedDeliveryDate,
	S.SupplierName,
	P.FullName
FROM Purchasing.Suppliers AS S
LEFT JOIN Purchasing.PurchaseOrders AS O ON S.SupplierID = O.SupplierID
LEFT JOIN Application.DeliveryMethods AS D ON O.DeliveryMethodID = D.DeliveryMethodID
LEFT JOIN Application.People AS P ON O.ContactPersonID = P.PersonID
WHERE (MONTH(O.ExpectedDeliveryDate) = 01 AND YEAR(O.ExpectedDeliveryDate) = 2013)
	AND (D.DeliveryMethodName IN ('Air Freight', 'Refrigerated Air Freight'))
	AND O.IsOrderFinalized = 1;

/*
5. Десять последних продаж (по дате продажи) с именем клиента и именем сотрудника,
который оформил заказ (SalespersonPerson).
Сделать без подзапросов.
*/

SELECT TOP 10
	O.OrderDate,
	C.CustomerName,
	P.FullName
FROM Sales.Orders O
LEFT JOIN Application.People P ON O.SalespersonPersonID = P.PersonID
LEFT JOIN Sales.Customers C ON O.CustomerID = C.CustomerID
ORDER BY O.OrderDate, O.OrderID DESC;

/*
6. Все ид и имена клиентов и их контактные телефоны,
которые покупали товар "Chocolate frogs 250g".
Имя товара смотреть в таблице Warehouse.StockItems.
*/

SELECT DISTINCT
	C.CustomerID,
	C.CustomerName,
	C.PhoneNumber
FROM Warehouse.StockItems AS I
JOIN Sales.OrderLines AS L ON I.StockItemID = L.StockItemID
JOIN Sales.Orders AS O ON L.OrderID = O.OrderID
JOIN Sales.Customers AS C ON O.CustomerID = C.CustomerID
WHERE I.StockItemName = N'Chocolate frogs 250g'
ORDER BY C.CustomerName;

/*
7. Посчитать среднюю цену товара, общую сумму продажи по месяцам
Вывести:
* Год продажи (например, 2015)
* Месяц продажи (например, 4)
* Средняя цена за месяц по всем товарам
* Общая сумма продаж за месяц

Продажи смотреть в таблице Sales.Invoices и связанных таблицах.
*/

SELECT
	YEAR(O.OrderDate) AS [Year],
	MONTH(O.OrderDate) AS [Month],
	AVG(L.UnitPrice)  AS [Avg],
	SUM(L.UnitPrice)  AS [Sum]
FROM Sales.Invoices AS I
LEFT JOIN Sales.Orders AS O ON I.OrderID = O.OrderID
LEFT JOIN Sales.OrderLines L ON O.OrderID = L.OrderID
GROUP BY MONTH(O.OrderDate), YEAR(O.OrderDate);

/*
8. Отобразить все месяцы, где общая сумма продаж превысила 10 000

Вывести:
* Год продажи (например, 2015)
* Месяц продажи (например, 4)
* Общая сумма продаж

Продажи смотреть в таблице Sales.Invoices и связанных таблицах.
*/

SELECT
	MONTH(O.OrderDate) AS [Month],
	YEAR(O.OrderDate) AS [Year],
	SUM(L.UnitPrice) AS [Sum]
FROM Sales.Invoices AS I
LEFT JOIN Sales.Orders AS O ON I.OrderID = O.OrderID
LEFT JOIN Sales.OrderLines L ON O.OrderID = L.OrderID
GROUP BY MONTH(O.OrderDate), YEAR(O.OrderDate)
HAVING SUM(L.UnitPrice) > 10000 -- Условие ничего не осеивает, сумма по всем месяцам выше. Что то не так понял?
ORDER BY YEAR(O.OrderDate) DESC, MONTH(O.OrderDate) DESC;

/*
9. Вывести сумму продаж, дату первой продажи
и количество проданного по месяцам, по товарам,
продажи которых менее 50 ед в месяц.
Группировка должна быть по году,  месяцу, товару.

Вывести:
* Год продажи
* Месяц продажи
* Наименование товара
* Сумма продаж
* Дата первой продажи
* Количество проданного

Продажи смотреть в таблице Sales.Invoices и связанных таблицах.
*/

SELECT
	YEAR(O.OrderDate) AS [Year],
	MONTH(O.OrderDate) AS [Month],
	S.StockItemName,
	SUM(L.UnitPrice) AS [Sum],
	MIN(O.OrderDate) AS [MinDate],
	SUM(L.PickedQuantity) AS [Quantity]
FROM Sales.Invoices AS I
LEFT JOIN Sales.Orders AS O ON I.OrderID = O.OrderID
LEFT JOIN Sales.OrderLines AS L ON O.OrderID = L.OrderID
LEFT JOIN Warehouse.StockItems AS S ON L.StockItemID = S.StockItemID
GROUP BY MONTH(O.OrderDate), YEAR(O.OrderDate), S.StockItemName
HAVING SUM(L.PickedQuantity) < 50
ORDER BY YEAR(O.OrderDate) DESC, MONTH(O.OrderDate) DESC;

-- ---------------------------------------------------------------------------
-- Опционально
-- ---------------------------------------------------------------------------
/*
Написать запросы 8-9 так, чтобы если в каком-то месяце не было продаж,
то этот месяц также отображался бы в результатах, но там были нули.
*/
