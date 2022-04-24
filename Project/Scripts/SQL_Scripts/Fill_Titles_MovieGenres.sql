
SELECT --TOP (1000) 
	  --t.[Id]
	  m.MovieId
      ,t.[tconst]
      ,t.[genre]
	  ,g.GenreId
  FROM [AMDB].[tmp].[TmpTitleBasicsGenres] AS t
  LEFT JOIN Titles.Movies AS m ON t.tconst = m.ImdbMovieId
  LEFT JOIN Dictionaries.Genres AS g ON t.genre = g.GenreName
  WHERE	 m.MovieId IS NULL OR g.GenreId IS NULL


-- FILL 

INSERT Titles.MovieGenres
(
    MovieId,
    GenreId
)
SELECT
	  m.MovieId
      ,g.GenreId
  FROM [AMDB].[tmp].[TmpTitleBasicsGenres] AS t
  LEFT JOIN Titles.Movies AS m ON t.tconst = m.ImdbMovieId
  LEFT JOIN Dictionaries.Genres AS g ON t.genre = g.GenreName
