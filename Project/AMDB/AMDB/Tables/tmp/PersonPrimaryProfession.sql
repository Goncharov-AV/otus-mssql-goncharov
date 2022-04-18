CREATE TABLE [tmp].[tmpPersonPrimaryProfession]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY ,
	[PersonImdbId]  NVARCHAR(255),
	[Profession]  NVARCHAR(255)
)
