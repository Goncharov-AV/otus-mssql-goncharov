CREATE TABLE [Companies].[Companies]
(
	[CompanyId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Companies_Companies_CompanyId] DEFAULT (NEXT VALUE FOR [Sequences].[CompanyId]),
	[CompanyName] NVARCHAR(255)
)
