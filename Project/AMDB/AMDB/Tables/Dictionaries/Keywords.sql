CREATE TABLE [Dictionaries].[Keywords]
(
	[KeywordId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Dictionaries_Keywords_KeywordId] DEFAULT (NEXT VALUE FOR [Sequences].[KeywordId]),
	[Keyword] NVARCHAR(255) NOT NULL
)
