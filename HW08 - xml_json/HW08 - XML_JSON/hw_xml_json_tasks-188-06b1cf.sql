/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.

Занятие "08 - Выборки из XML и JSON полей".

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
Примечания к заданиям 1, 2:
* Если с выгрузкой в файл будут проблемы, то можно сделать просто SELECT c результатом в виде XML. 
* Если у вас в проекте предусмотрен экспорт/импорт в XML, то можете взять свой XML и свои таблицы.
* Если с этим XML вам будет скучно, то можете взять любые открытые данные и импортировать их в таблицы (например, с https://data.gov.ru).
* Пример экспорта/импорта в файл https://docs.microsoft.com/en-us/sql/relational-databases/import-export/examples-of-bulk-import-and-export-of-xml-documents-sql-server
*/


/*
1. В личном кабинете есть файл StockItems.xml.
Это данные из таблицы Warehouse.StockItems.
Преобразовать эти данные в плоскую таблицу с полями, аналогичными Warehouse.StockItems.
Поля: StockItemName, SupplierID, UnitPackageID, OuterPackageID, QuantityPerOuter, TypicalWeightPerUnit, LeadTimeDays, IsChillerStock, TaxRate, UnitPrice 

Опционально - если вы знакомы с insert, update, merge, то загрузить эти данные в таблицу Warehouse.StockItems.
Существующие записи в таблице обновить, отсутствующие добавить (сопоставлять записи по полю StockItemName). 
*/

DECLARE @xmlDocument XML
DECLARE @handle INT

SELECT @xmlDocument = BulkColumn
FROM OPENROWSET
(BULK 'C:\_Sources\otus-mssql-goncharov\HW08 - XML_JSON\HW08 - XML_JSON\StockItems-188-ce21c6.xml', SINGLE_CLOB) AS DATA

EXEC sp_xml_preparedocument @handle OUTPUT, @xmlDocument

SELECT * 
FROM OPENXML(@handle,N'StockItems/Item')
WITH (
	StockItemName	NVARCHAR(255)	'@Name',
	SupplierId		INT				'SupplierID',
	UnitPackageID	INT				'Package/UnitPackageID',
	OuterPackageID	INT				'Package/OuterPackageID',
	LeadTimeDays	INT				'LeadTimeDays',
	QuantityPerOuter	INT			'Package/QuantityPerOuter',
	IsChillerStock	INT				'IsChillerStock',
	TaxRate			DECIMAL(18,3)	'TaxRate',
	UnitPrice		DECIMAL(18,2)	'UnitPrice',
	TypicalWeightPerUnit	DECIMAL(18,2)		'Package/TypicalWeightPerUnit'
)
GO
/*
2. Выгрузить данные из таблицы StockItems в такой же xml-файл, как StockItems.xml
*/

SELECT
		StockItemName	AS [@Name],
		SupplierID		AS [SupplierID],
		UnitPackageID	AS [Package/UnitPackageID],
		OuterPackageID	AS [Package/OuterPackageID],
		QuantityPerOuter	AS [Package/QuantityPerOuter],
		TypicalWeightPerUnit AS [Package/TypicalWeightPerUnit],
		LeadTimeDays	AS [LeadTimeDays],
		IsChillerStock	AS [IsChillerStock],
		TaxRate			AS [TaxRate],
		UnitPrice		AS [UnitPrice]
	FROM Warehouse.StockItems
	FOR XML PATH ('Item'), ROOT ('StockItems')
GO


/*
3. В таблице Warehouse.StockItems в колонке CustomFields есть данные в JSON.
Написать SELECT для вывода:
- StockItemID
- StockItemName
- CountryOfManufacture (из CustomFields)
- FirstTag (из поля CustomFields, первое значение из массива Tags)
*/

USE WideWorldImporters

SELECT 
	StockItemID,
	StockItemName,
	JSON_VALUE(CustomFields,'$.CountryOfManufacture') AS CountryOfManufacture,
	JSON_VALUE(CustomFields,'$.Tags[0]') AS FirstTag
FROM Warehouse.StockItems

/*
4. Найти в StockItems строки, где есть тэг "Vintage".
Вывести: 
- StockItemID
- StockItemName
- (опционально) все теги (из CustomFields) через запятую в одном поле

Тэги искать в поле CustomFields, а не в Tags.
Запрос написать через функции работы с JSON.
Для поиска использовать равенство, использовать LIKE запрещено.

Должно быть в таком виде:
... where ... = 'Vintage'

Так принято не будет:
... where ... Tags like '%Vintage%'
... where ... CustomFields like '%Vintage%' 
*/


USE WideWorldImporters

SELECT 
	S.StockItemID,
	S.StockItemName,
	JSON_VALUE(S.CustomFields,'$.Tags[0]') AS FirstTag,
	JSON_QUERY(S.CustomFields, '$.Tags') AS Tags
FROM Warehouse.StockItems S
CROSS APPLY OPENJSON(S.CustomFields, '$.Tags') tags
WHERE tags.value = N'Vintage'

