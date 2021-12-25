
USE WideWorldImporters
SELECT * FROM Warehouse.StockItems



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