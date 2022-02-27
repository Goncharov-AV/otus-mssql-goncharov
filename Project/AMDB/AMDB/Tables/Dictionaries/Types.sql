CREATE TABLE [Dictionaries].[Types]
(
	[TypeId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Dictionary_Types_TypeId] DEFAULT (NEXT VALUE FOR [Sequences].[TypeId]),
	[Type] NVARCHAR(255) NOT NULL
)
