USE WideWorldImporters

SELECT 
	StockItemID,
	StockItemName,
	JSON_VALUE(CustomFields,'$.CountryOfManufacture') AS CountryOfManufacture,
	JSON_VALUE(CustomFields,'$.Tags[0]') AS FirstTag
FROM Warehouse.StockItems

