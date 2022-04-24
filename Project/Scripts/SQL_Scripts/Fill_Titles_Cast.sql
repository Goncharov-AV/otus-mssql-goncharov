SELECT TOP (1000) [CastId]
      ,[MovieId]
      ,[PersonId]
	  ,[ProfessionId]
      ,[Character]
  FROM [AMDB].[Titles].[Cast]

INSERT [AMDB].[Titles].[Cast]([MovieId]
      ,[PersonId]
	  ,[ProfessionId]
      ,[Character])
SELECT 
	  m.MovieId
	  ,per.PersonId
	  ,pro.ProfessionId
	  ,CASE WHEN pri.character = '\N' THEN NULL ELSE pri.character END
  FROM [AMDB].[tmp].[tmpPrincipals] AS pri
  LEFT JOIN Titles.Movies AS m ON pri.tconst = m.ImdbMovieId
  LEFT JOIN Names.Persons AS per ON pri.nconst = per.PersonImdbId
  LEFT JOIN Dictionaries.Professions AS pro ON pri.category = pro.Profession
  WHERE pri.category IN ('self','archive_sound','actress','actor','archive_footage')
	AND per.PersonId IS NOT NULL AND m.MovieId IS NOT NULL  
