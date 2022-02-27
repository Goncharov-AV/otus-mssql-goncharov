CREATE TABLE [Titles].[EpisodesInfo]
(
	[EpisodeInfoId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Title_EpisodesInfo_EpisodeInfoId] DEFAULT (NEXT VALUE FOR [Sequences].[EpisodeInfoId]),
	[SeriesId] INT NOT NULL,
	[SeasonNumber] INT NOT NULL,
	[EpisodeNumber] INT NOT NULL,
	CONSTRAINT FK_Titles_EpisodeInfo_Titles_Movies FOREIGN KEY([SeriesId]) REFERENCES [Titles].[Movies]([MovieId])
)
