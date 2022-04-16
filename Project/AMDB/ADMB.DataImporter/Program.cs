using ADMB.DataImporter;
using ADMB.DataImporter.CsvModels;
using ADMB.DataImporter.Fillers;
using AMDB.Entities.DbContext;
using AMDB.Entities.Models;

using (AmdbContext dbContext = new AmdbContext())
{
    //Companies.Companies
    //Dictionaries.ContentRatings
    //Dictionaries.Countries
    
    //Dictionaries.Genres
    var genresFiller = new UniversalDictionaryFiller<TitleBasic, Genre>(CsvFiles.TitleBasics, dbContext, (s => new Genre() {GenreName = s}), "genres");
    genresFiller.Fill();

    //Dictionaries.Keywords
    //Dictionaries.Languages
    //Dictionaries.MovieTypes

    //Dictionaries.Professions
    //var professionFiller = new DictionariesProfessionsFiller(CsvFiles.NameBasics, dbContext);
    //professionFiller.Fill();

    //Names.KnownFor

    //Names.Persons
    //var personsFiller = new NamesPersonsFiller(CsvFiles.NameBasics, dbContext);
    //personsFiller.Fill();

    //Names.PrimaryProfessions
    //var primaryProfessionFiller = new PrimaryProfessionFiller(CsvFiles.NameBasics, dbContext);
    //primaryProfessionFiller.Fill();

    //Tmp.PrimaryProfessions
    //var personPrimaryProfessionFiller = new TmpPersonPrimaryProfessionFiller(CsvFiles.NameBasics, dbContext);
    //personPrimaryProfessionFiller.Fill();

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
    
}


Console.WriteLine("Done!");
