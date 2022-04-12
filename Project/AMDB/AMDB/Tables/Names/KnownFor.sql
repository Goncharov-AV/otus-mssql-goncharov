CREATE TABLE [Names].[KnownFor]
(
	[KnownForId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Names_KnownFor_KnownForId] DEFAULT (NEXT VALUE FOR [Sequences].[KnownForId]),
	[PersonId] INT NOT NULL,
	[MovieId] INT NOT NULL,
	CONSTRAINT FK_Names_KnownFor_Names_Persons FOREIGN KEY([PersonId]) REFERENCES [Names].[Persons]([PersonId]),
	CONSTRAINT FK_Names_KnownFor_Titles_Movies FOREIGN KEY([MovieId]) REFERENCES [Titles].[Movies]([MovieId]),
)

GO

CREATE INDEX [IX_KnownFor_PersonId] ON [Names].[KnownFor] ([PersonId])
GO

CREATE INDEX [IX_KnownFor_[MovieId] ON [Names].[KnownFor] ([MovieId])
