CREATE TABLE [tmp].[TmpKnownFor]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY ,
	[PersonImdbId]  NVARCHAR(255),
	[KnownFor]  NVARCHAR(255)
)

GO

CREATE INDEX [IX_TmpKnownFor_KnownFor] ON [tmp].[TmpKnownFor] ([KnownFor])

GO

CREATE INDEX [IX_TmpKnownFor_PersonImdbId] ON [tmp].[TmpKnownFor] ([PersonImdbId])
