CREATE TABLE [Titles].[Cast]
(
	[CastId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Titles_Cast_CastId] DEFAULT (NEXT VALUE FOR [Sequences].[CastId]),
	[MovieId] INT NOT NULL,
	[PersonId] INT NOT NULL,
	[Character] NVARCHAR(255),
	CONSTRAINT FK_Titles_Cast_Titles_Movies FOREIGN KEY([MovieId]) REFERENCES [Titles].[Movies]([MovieId]),
	CONSTRAINT FK_Titles_Cast_Names_Persons FOREIGN KEY([PersonId]) REFERENCES [Names].[Persons]([PersonId])
)
