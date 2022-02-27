CREATE TABLE [Names].[Persons]
(
	[PersonId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Names_Persons_PersonId] DEFAULT (NEXT VALUE FOR [Sequences].[PersonId]),
	[PersonImdbId] NVARCHAR(255),
	[Name] NVARCHAR(255),
	[Summary] NVARCHAR(MAX),
	[BirthDate] DATETIME2,
	[DeathDate] DATETIME2
)
