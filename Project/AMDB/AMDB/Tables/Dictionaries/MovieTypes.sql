CREATE TABLE [Dictionaries].[MovieTypes]
(
	[MovieTypeId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Dictionary_MovieTypes_MoveiTypeId] DEFAULT (NEXT VALUE FOR [Sequences].[MovieTypeId]),
	[MovieTypeName] NVARCHAR(255) NOT NULL
)
