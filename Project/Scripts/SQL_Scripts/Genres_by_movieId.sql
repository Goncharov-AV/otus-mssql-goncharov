
SELECT TOP (1000) [MovieGenreId]
      ,mg.[MovieId]
      ,mg.[GenreId]
  FROM [AMDB].[Titles].[MovieGenres] AS mg