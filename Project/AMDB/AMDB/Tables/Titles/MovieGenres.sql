CREATE TABLE [Titles].[MovieGenres]
(
	[MovieGenreId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Titles_MovieGenres_MovieGenreId] DEFAULT (NEXT VALUE FOR [Sequences].[MovieGenreId]),
	[MovieId] INT NOT NULL,
	[GenreId] INT NOT NULL,
	CONSTRAINT FK_Titles_MovieGenres_Titles_Movies FOREIGN KEY([MovieId]) REFERENCES [Titles].[Movies]([MovieId]),
	CONSTRAINT FK_Titles_MovieGenres_Dictionaries_Genres FOREIGN KEY([GenreId]) REFERENCES [Dictionaries].[Genres]([GenreId])
)
