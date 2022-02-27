CREATE TABLE [Titles].[BoxOffice]
(
	[BoxOfficeId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Titles_BoxOffice_BoxOfficeId] DEFAULT (NEXT VALUE FOR [Sequences].[BoxOfficeId]),
	[Buget] NVARCHAR(255),
	[OpeningWeekendUSA] NVARCHAR(255),
    [GrossUSA] NVARCHAR(255),
    [CumulativeWorldwideGross] NVARCHAR(255)
)
