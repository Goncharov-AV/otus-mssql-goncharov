USE WideWorldImporters

SELECT 
	S.StockItemID,
	S.StockItemName,
	JSON_VALUE(S.CustomFields,'$.Tags[0]') AS FirstTag,
	JSON_QUERY(S.CustomFields, '$.Tags') AS Tags
FROM Warehouse.StockItems S
CROSS APPLY OPENJSON(S.CustomFields, '$.Tags') tags
WHERE tags.value = N'Vintage'

