CREATE TABLE [Titles].[Similars]
(
	[SimilarId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Titles_Similars_SimilarId] DEFAULT (NEXT VALUE FOR [Sequences].[SimilarId]),
	[MovieId] INT NOT NULL,
	[SimilarMovieId] INT NOT NULL,
	CONSTRAINT FK_Titles_Similars_MovieId_Titles_Movies FOREIGN KEY([MovieId]) REFERENCES [Titles].[Movies]([MovieId]),
	CONSTRAINT FK_Titles_Similars_SimilarMovieId_Titles_Movies FOREIGN KEY([SimilarMovieId]) REFERENCES [Titles].[Movies]([MovieId])
)
