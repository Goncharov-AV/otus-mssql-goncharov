CREATE TABLE [Dictionaries].[Genres]
(
	[GenreId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Dictionary_Genres_GenreId] DEFAULT (NEXT VALUE FOR [Sequences].[GenreId]),
	[GenreName] NVARCHAR(255) NOT NULL
)

