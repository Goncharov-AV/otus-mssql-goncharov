SELECT TOP (1000) [EpisodeInfoId]
      ,[EpisodeId]
      ,[SeriesId]
      ,[SeasonNumber]
      ,[EpisodeNumber]
  FROM [AMDB].[Titles].[EpisodesInfo]

SELECT TOP (1000) [Id]
      ,[tconst]
      ,[parentTconst]
      ,[seasonNumber]
      ,[episodeNumber]
  FROM [AMDB].[tmp].[tmpEpisodes]

SELECT TOP (1000) 
	  m1.MovieId
      ,e.[tconst]
	  ,m2.MovieId
      ,e.[parentTconst]
      ,e.[seasonNumber]
      ,e.[episodeNumber]
  FROM [AMDB].[tmp].[tmpEpisodes] AS e
  LEFT JOIN Titles.Movies m1 ON e.tconst = m1.ImdbMovieId
  LEFT JOIN Titles.Movies m2 ON e.parentTconst= m2.ImdbMovieId
  WHERE m1.MovieId IS NULL OR m2.MovieId IS NULL

INSERT [AMDB].[Titles].[EpisodesInfo]([EpisodeId],[SeriesId],[SeasonNumber],[EpisodeNumber])
SELECT 
	  m1.MovieId
      ,m2.MovieId
      ,e.[seasonNumber]
      ,e.[episodeNumber]
  FROM [AMDB].[tmp].[tmpEpisodes] AS e
  LEFT JOIN Titles.Movies m1 ON e.tconst = m1.ImdbMovieId
  LEFT JOIN Titles.Movies m2 ON e.parentTconst= m2.ImdbMovieId
  WHERE m1.MovieId IS NOT NULL AND m2.MovieId IS NOT NULL