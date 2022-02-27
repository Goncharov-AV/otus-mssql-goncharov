CREATE TABLE [Dictionaries].[Languages]
(
	[Id] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Dictionary_Languages_LanguageId] DEFAULT (NEXT VALUE FOR [Sequences].[LanguageId]),
	[Language] NVARCHAR(255) NOT NULL
)
