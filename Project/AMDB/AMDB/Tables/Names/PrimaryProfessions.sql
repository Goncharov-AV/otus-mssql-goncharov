CREATE TABLE [Names].[PrimaryProfessions]
(
	[PrimaryProfessionId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Names_PrimaryProfessions_PrimaryProfessionId] DEFAULT (NEXT VALUE FOR [Sequences].[PrimaryProfessionId]),
	[PersonId] INT NOT NULL,
	[ProfessionId] INT NOT NULL,
	CONSTRAINT FK_Names_PrimaryProfessions_Names_Persons FOREIGN KEY([PersonId]) REFERENCES [Names].[Persons]([PersonId]),
	CONSTRAINT FK_Names_PrimaryProfessions_Dictionaries_Professions FOREIGN KEY([ProfessionId]) REFERENCES [Dictionaries].[Professions]([ProfessionId])
)
