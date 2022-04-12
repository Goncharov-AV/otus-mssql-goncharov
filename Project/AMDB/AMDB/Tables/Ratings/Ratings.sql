CREATE TABLE [Ratings].[Ratings]
(
	[RatingId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Ratings_Ratings_RatingId] DEFAULT (NEXT VALUE FOR [Sequences].[RatingId]),
	[RatingNameId] INT NOT NULL,
	[MovieId] INT NOT NULL,
	[Rating] DECIMAL(3,1) NOT NULL,
	CONSTRAINT FK_Ratings_Ratings_Ratings_RatingNames FOREIGN KEY([RatingNameId]) REFERENCES [Ratings].[RatingNames]([RatingNameId]),
	CONSTRAINT FK_Ratings_Ratings_Titles_Movies FOREIGN KEY([MovieId]) REFERENCES [Titles].[Movies]([MovieId]),
)

GO

CREATE INDEX [IX_Ratings_RatingNameId] ON [Ratings].[Ratings] ([RatingNameId])

GO

CREATE INDEX [IX_Ratings_MovieId] ON [Ratings].[Ratings] ([MovieId])
