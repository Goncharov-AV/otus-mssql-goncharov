CREATE TABLE [tmp].[tmpEpisodes]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[tconst] NVARCHAR(255),
	[parentTconst] NVARCHAR(255),
	[seasonNumber] INT,
	[episodeNumber] INT
)

GO

CREATE INDEX [IX_Episodes_tconst] ON [tmp].[tmpEpisodes] ([tconst])

GO

CREATE INDEX [IX_Episodes_parentTconst] ON [tmp].[tmpEpisodes] ([parentTconst])