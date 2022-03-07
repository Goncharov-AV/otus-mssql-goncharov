CREATE TABLE [Titles].[MovieLanguages]
(
	[MovieLanguageId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Titles_MovieLanguages_MovieLanguageId] DEFAULT (NEXT VALUE FOR [Sequences].[MovieLanguageId]),
	[MovieId] INT NOT NULL,
	[LanguageId] INT NOT NULL,
	CONSTRAINT FK_Titles_MovieLanguages_Titles_Movies FOREIGN KEY([MovieId]) REFERENCES [Titles].[Movies]([MovieId]),
	CONSTRAINT FK_Titles_MovieLanguages_Dictionaries_Languages FOREIGN KEY([LanguageId]) REFERENCES [Dictionaries].[Languages]([LanguageId])
)
