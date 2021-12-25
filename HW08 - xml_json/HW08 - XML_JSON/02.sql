/*
  <Item Name="&quot;The Gu&quot; red shirt XML tag t-shirt (Black) 3XXL">
    <SupplierID>4</SupplierID>
    <Package>
      <UnitPackageID>7</UnitPackageID>
      <OuterPackageID>6</OuterPackageID>
      <QuantityPerOuter>12</QuantityPerOuter>
      <TypicalWeightPerUnit>0.400</TypicalWeightPerUnit>
    </Package>
    <LeadTimeDays>7</LeadTimeDays>
    <IsChillerStock>0</IsChillerStock>
    <TaxRate>20.000</TaxRate>
    <UnitPrice>18.000000</UnitPrice>
  </Item> 
*/

USE WideWorldImporters

/*
EXEC master.dbo.sp_configure 'show advanced options', 1
RECONFIGURE
EXEC master.dbo.sp_configure 'xp_cmdshell', 1
RECONFIGURE
*/

DECLARE @xml AS XML = (
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
)

DECLARE @xmlChar AS VARCHAR(max) = CAST(@xml AS VARCHAR(max))
SET @xmlChar = REPLACE(REPLACE(@xmlChar, '>', '^>'), '<', '^<')

GO
EXEC xp_cmdshell 'bcp "SELECT @xmlChar" queryout "c:\temp\test.txt" -T -c -t,'


--DECLARE @command VARCHAR(8000) = 'echo ' + @xmlChar + ' > c:\temp\test.txt'
--EXEC xp_cmdshell @command
-- Не заменяются кавычки, решения есть только обходные