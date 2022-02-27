CREATE TABLE [Titles].[Teams]
(
	[TeamId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Title_Teams_TeamId] DEFAULT (NEXT VALUE FOR [Sequences].[TeamId]),
	[MovieId] INT NOT NULL,
	[PersonId] INT NOT NULL,
	[ProfessionId] INT NOT NULL,
	CONSTRAINT FK_Titles_Teams_Titles_Movies FOREIGN KEY([MovieId]) REFERENCES [Titles].[Movies]([MovieId]),
	CONSTRAINT FK_Titles_Teams_Names_Persons FOREIGN KEY([PersonId]) REFERENCES [Names].[Persons]([PersonId]),
	CONSTRAINT FK_Titles_Teams_Dictionaries_Professions FOREIGN KEY([ProfessionId]) REFERENCES [Dictionaries].[Professions]([ProfessionId])
)
