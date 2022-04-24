CREATE TABLE [Titles].[Movies]
(
	[MovieId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Title_Movies_MovieId] DEFAULT (NEXT VALUE FOR [Sequences].[MovieId]),
	[ImdbMovieId] NVARCHAR(255),
	[Title] NVARCHAR(255),
	[OriginalTitle] NVARCHAR(255),
	[FullTitle] NVARCHAR(255),
	[MovieTypeId] INT,
	[Year] INT,
	[ReleaseDate] DATETIME2,
	[RuntimeMins] INT,
	[Plot] NVARCHAR(MAX),
	[ContentRatingId] INT,
	[YearEnd] INT,
	[BoxOfficeId] INT,
	CONSTRAINT FK_Titles_Movies_Dictionaries_MoveiTypes FOREIGN KEY([MovieTypeId]) REFERENCES [Dictionaries].[MovieTypes]([MovieTypeId]),
	CONSTRAINT FK_Titles_Movies_Dictionaties_ContentRatings FOREIGN KEY([ContentRatingId]) REFERENCES [Dictionaries].[ContentRatings]([ContentRatingId]),
	CONSTRAINT FK_Titles_Movies_Titles_BoxOffice FOREIGN KEY([BoxOfficeId]) REFERENCES [Titles].[BoxOffice]([BoxOfficeId])
)

GO

CREATE INDEX [IX_Movies_ImdbMovieId] ON [Titles].[Movies] ([ImdbMovieId])
