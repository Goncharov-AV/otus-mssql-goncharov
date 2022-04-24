CREATE TABLE [Titles].[EpisodesInfo]
(
	[EpisodeInfoId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Title_EpisodesInfo_EpisodeInfoId] DEFAULT (NEXT VALUE FOR [Sequences].[EpisodeInfoId]),
	[EpisodeId] INT NOT NULL,
	[SeriesId] INT NOT NULL,
	[SeasonNumber] INT,
	[EpisodeNumber] INT,
	CONSTRAINT FK_Titles_EpisodeInfo_SeriesId_Titles_Movies FOREIGN KEY([SeriesId]) REFERENCES [Titles].[Movies]([MovieId]),
	CONSTRAINT FK_Titles_EpisodeInfo_EpisodeId_Titles_Movies FOREIGN KEY([EpisodeId]) REFERENCES [Titles].[Movies]([MovieId])
)
