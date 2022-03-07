CREATE TABLE [Titles].[MovieCountries]
(
	[MovieCountryId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Titles_MovieCountries_MovieCountryId] DEFAULT (NEXT VALUE FOR [Sequences].[MovieCountryId]),
	[MovieId] INT NOT NULL,
	[CountryId] INT NOT NULL,
	CONSTRAINT FK_Titles_MovieCountries_Titles_Movies FOREIGN KEY([MovieId]) REFERENCES [Titles].[Movies]([MovieId]),
	CONSTRAINT FK_Titles_MovieCountries_Dictionaries_Countries FOREIGN KEY([CountryId]) REFERENCES [Dictionaries].[Countries]([CountryId])
)
