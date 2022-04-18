CREATE TABLE [tmp].[TmpTitleBasicsGenres]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY ,
	[tconst]  NVARCHAR(255),
	[genre]  NVARCHAR(255)
)

GO

CREATE INDEX [IX_TmpTitleBasicsGenres_genre] ON [tmp].[TmpTitleBasicsGenres] ([genre])

GO

CREATE INDEX [IX_TmpTitleBasicsGenres_tconst] ON [tmp].[TmpTitleBasicsGenres] ([tconst])
