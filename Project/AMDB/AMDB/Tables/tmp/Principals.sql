CREATE TABLE [tmp].[tmpPrincipals]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[tconst] NVARCHAR(255),
	[ordering] INT,
	[nconst] NVARCHAR(255),
	[category] NVARCHAR(255),
	[job] NVARCHAR(255),
	[character] NVARCHAR(255),

)
GO
CREATE INDEX [IX_Principals_tconst] ON [tmp].[tmpPrincipals] ([tconst])
GO
CREATE INDEX [IX_Principals_nconst] ON [tmp].[tmpPrincipals] ([nconst])