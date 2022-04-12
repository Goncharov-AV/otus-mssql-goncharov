﻿using ADMB.DataImporter;
using ADMB.DataImporter.Fillers;
using AMDB.Entities.DbContext;

AmdbContext dbContext = new AmdbContext();

//Companies.Companies
//Dictionaries.ContentRatings
//Dictionaries.Countries
//Dictionaries.Genres
//Dictionaries.Keywords
//Dictionaries.Languages
//Dictionaries.MovieTypes

//Dictionaries.Professions
//var professionFiller = new DictionariesProfessionsFiller(CsvFiles.NameBasics, dbContext);
//professionFiller.Fill();

//Names.KnownFor

//Names.Persons
var personsFiller = new NamesPersonsFiller(CsvFiles.NameBasics, dbContext);
personsFiller.Fill();

//Names.PrimaryProfessions
//Ratings.RatingNames
//Ratings.Ratings
//Titles.BoxOffice
//Titles.Cast
//Titles.EpisodesInfo
//Titles.MovieCompanies
//Titles.MovieCountries
//Titles.MovieGenres
//Titles.MovieKeywords
//Titles.MovieLanguages
//Titles.Movies
//Titles.Similars
//Titles.Teams

Console.WriteLine("Done!");
