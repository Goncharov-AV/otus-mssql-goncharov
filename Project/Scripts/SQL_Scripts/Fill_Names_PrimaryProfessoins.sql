USE AMDB

SELECT count(*) FROM Names.PrimaryProfessions 

INSERT INTO Names.PrimaryProfessions (PersonId,ProfessionId)
SELECT --TOP 1
	--ppp.PersonImdbId, 
	--ppp.Profession,
	p.PersonId,
	o.ProfessionId
FROM [tmp].[PersonPrimaryProfession] AS ppp
LEFT JOIN [Names].[Persons] AS p ON ppp.PersonImdbId = p.PersonImdbId
LEFT JOIN [Dictionaries].Professions AS o ON ppp.Profession = o.Profession

--DELETE FROM Names.PrimaryProfessions

SELECT TOP 1000000
	ppp.PersonImdbId, 
	ppp.Profession,
	p.PersonId,
	o.ProfessionId
FROM [tmp].[PersonPrimaryProfession] AS ppp
LEFT JOIN [Names].[Persons] AS p ON ppp.PersonImdbId = p.PersonImdbId
LEFT JOIN [Dictionaries].Professions AS o ON ppp.Profession = o.Profession
WHERE o.ProfessionId IS NULL
