CREATE TABLE [tmp].[tmpCrew]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[tconst] NVARCHAR(255),
	[directors] NVARCHAR(255),
	[writers] NVARCHAR(255),
)

GO
CREATE INDEX [IX_Crew_tconst] ON [tmp].[tmpCrew] ([tconst])
GO
CREATE INDEX [IX_Crew_directors] ON [tmp].[tmpCrew] ([directors])
GO
CREATE INDEX [IX_Crew_writers] ON [tmp].[tmpCrew] ([writers])
