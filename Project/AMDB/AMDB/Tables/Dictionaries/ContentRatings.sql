CREATE TABLE [Dictionaries].[ContentRatings]
(
	[ContentRatingId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Dictionary_ContentRatings_ContentRatingId] DEFAULT (NEXT VALUE FOR [Sequences].[ContentRatingId]),
	[ContentRating] NVARCHAR(255),
	[AgeFrom] INT
)
