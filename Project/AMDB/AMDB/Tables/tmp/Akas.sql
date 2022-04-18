CREATE TABLE [tmp].[tmpAkas]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[titleId] NVARCHAR(255),
	[ordering] INT,
	[title] NVARCHAR(255),
	[region] NVARCHAR(255),
	[language] NVARCHAR(255),
	[types] NVARCHAR(255),
	[attributes] NVARCHAR(255),
	[isOriginalTitle] NVARCHAR(255),
)

GO

CREATE INDEX [IX_Akas_titleId] ON [tmp].[tmpAkas] ([titleId])
