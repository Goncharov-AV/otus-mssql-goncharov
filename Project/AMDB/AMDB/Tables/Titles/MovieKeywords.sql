CREATE TABLE [Titles].[MovieKeywords]
(
	[MovieKeywordsId] INT NOT NULL PRIMARY KEY CONSTRAINT [DF_Titles_MovieKeywords_MovieKeywordId] DEFAULT (NEXT VALUE FOR [Sequences].[MovieKeywordId]),
	[MovieId] INT NOT NULL,
	[KeywordId] INT NOT NULL,
	CONSTRAINT FK_Titles_MovieKeywords_Titles_Movies FOREIGN KEY([MovieId]) REFERENCES [Titles].[Movies]([MovieId]),
	CONSTRAINT FK_Titles_MovieKeywords_Dictionaries_Keywords FOREIGN KEY([KeywordId]) REFERENCES [Dictionaries].[Keywords]([KeywordId])
)
