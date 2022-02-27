CREATE TABLE [Titles].[MovieCompanies]
(
	[MovieCompanyId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Title_MovieCompanies_MovieCompanyId] DEFAULT (NEXT VALUE FOR [Sequences].[MovieCompanyId]),
	[MovieId] INT NOT NULL,
	[CompanyId] INT NOT NULL,
	CONSTRAINT FK_Titles_MovieCompanies_Titles_Movies FOREIGN KEY([MovieId]) REFERENCES [Titles].[Movies]([MovieId]),
	CONSTRAINT FK_Titles_MovieCompanies_Companies_Companies FOREIGN KEY([CompanyId]) REFERENCES [Companies].[Companies]([CompanyId]),
)
