
SELECT TOP (1000) [Id]
      ,[PersonImdbId]
      ,[KnownFor]
  FROM [AMDB].[tmp].[TmpKnownFor]

SELECT TOP (1000) [KnownForId]
      ,[PersonId]
      ,[MovieId]
  FROM [AMDB].[Names].[KnownFor]

SELECT TOP 1000
	  p.PersonId
      ,t.[PersonImdbId]
      ,t.[KnownFor]
	  ,m.MovieId
  FROM [AMDB].[tmp].[TmpKnownFor] AS t
  JOIN Titles.Movies AS m ON t.KnownFor = m.ImdbMovieId
  JOIN Names.Persons AS p ON t.PersonImdbId = p.PersonImdbId
  WHERE p.PersonId IS NULL OR m.MovieId IS NULL

INSERT [AMDB].[Names].[KnownFor]([PersonId],[MovieId])
SELECT
	  p.PersonId
	  ,m.MovieId
  FROM [AMDB].[tmp].[TmpKnownFor] AS t
  JOIN Titles.Movies AS m ON t.KnownFor = m.ImdbMovieId
  JOIN Names.Persons AS p ON t.PersonImdbId = p.PersonImdbId
