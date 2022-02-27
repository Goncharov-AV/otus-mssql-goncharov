CREATE TABLE [Dictionaries].[Countries]
(
	[CountryId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Dictionary_Countries_CountryId] DEFAULT (NEXT VALUE FOR [Sequences].[CountryId]),
	[Country] NVARCHAR(255) NOT NULL
)
