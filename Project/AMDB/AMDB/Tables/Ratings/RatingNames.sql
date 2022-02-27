CREATE TABLE [Ratings].[RatingNames]
(
	[RatingNameId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Ratings_RatingNames_RatingNameId] DEFAULT (NEXT VALUE FOR [Sequences].[RatingNameId]),
	[Name] NVARCHAR(255) NOT NULL
)
