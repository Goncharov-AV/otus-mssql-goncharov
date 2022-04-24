CREATE TABLE [tmp].[tmpAkas]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[titleId] NVARCHAR(10),
	[ordering] INT,
	[title] NVARCHAR(900),
	[region] NVARCHAR(10),
	[language] NVARCHAR(10),
	[types] NVARCHAR(30),
	[attributes] NVARCHAR(255),
	[isOriginalTitle] NVARCHAR(10),
)

GO

CREATE INDEX [IX_Akas_titleId] ON [tmp].[tmpAkas] ([titleId])
