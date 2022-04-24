SELECT TOP (1000) [TeamId]
      ,[MovieId]
      ,[PersonId]
      ,[ProfessionId]
      ,[Job]
  FROM [AMDB].[Titles].[Teams]


INSERT [AMDB].[Titles].[Teams]([MovieId]
      ,[PersonId]
	  ,[ProfessionId]
      ,[Job])
SELECT 
	  m.MovieId
	  ,per.PersonId
	  ,pro.ProfessionId
	  ,CASE WHEN pri.[Job] = '\N' THEN NULL ELSE pri.[Job] END AS [Job]
  FROM [AMDB].[tmp].[tmpPrincipals] AS pri
  LEFT JOIN Titles.Movies AS m ON pri.tconst = m.ImdbMovieId
  LEFT JOIN Names.Persons AS per ON pri.nconst = per.PersonImdbId
  LEFT JOIN Dictionaries.Professions AS pro ON pri.category = pro.Profession
  WHERE pri.category NOT IN ('self','archive_sound','actress','actor','archive_footage')
	AND per.PersonId IS NOT NULL AND m.MovieId IS NOT NULL  
  
