CREATE TABLE [tmp].[tmpTitleRatings]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY ,
	[tconst] NVARCHAR(255),
	[averageRating] DECIMAL(3,1),
	[numVotes] INT
)

GO

CREATE INDEX [IX_TItleRatings_tconst] ON [tmp].[tmpTitleRatings] ([tconst])
