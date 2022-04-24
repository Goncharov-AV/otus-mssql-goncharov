/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [RatingId]
      ,[RatingNameId]
      ,[MovieId]
      ,[Rating]
  FROM [AMDB].[Ratings].[Ratings]

INSERT [AMDB].[Ratings].[Ratings]([RatingNameId],[MovieId],[Rating])
SELECT 
	  1 AS [RatingNameId]
      ,m.MovieId AS [MovieId]
      ,[averageRating] AS [Rating]
  FROM [AMDB].[tmp].[tmpTitleRatings] AS r
  LEFT JOIN [AMDB].[Titles].[Movies] AS m ON m.ImdbMovieId = r.tconst
