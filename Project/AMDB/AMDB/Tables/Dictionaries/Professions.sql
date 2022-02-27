CREATE TABLE [Dictionaries].[Professions]
(
	[ProfessionId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Dictionaries_Professions_ProfessionId] DEFAULT (NEXT VALUE FOR [Sequences].[ProfessionId]),
	[Profession] NVARCHAR(255) NOT NULL
)
