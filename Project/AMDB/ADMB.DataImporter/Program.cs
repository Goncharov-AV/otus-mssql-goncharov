using ADMB.DataImporter;
using ADMB.DataImporter.CsvModels;
using ADMB.DataImporter.Fillers;
using AMDB.Entities.DbContext;
using AMDB.Entities.Models;

using (AmdbContext dbContext = new AmdbContext())
{
    ////Companies.Companies
    ////Dictionaries.ContentRatings
    ////Dictionaries.Countries
    ////Dictionaries.Keywords
    ////Dictionaries.Languages
    ////Names.KnownFor
    ////Names.PrimaryProfessions
    ////Ratings.RatingNames
    ////Ratings.Ratings
    ////Titles.BoxOffice
    ////Titles.Cast
    ////Titles.EpisodesInfo
    ////Titles.MovieCompanies
    ////Titles.MovieCountries
    ////Titles.MovieGenres
    ////Titles.MovieKeywords
    ////Titles.MovieLanguages
    ////Titles.Similars
    ////Titles.Teams


    //Dictionaries.Genres
    var genresFiller = new UniversalDictionaryFiller<TitleBasic, Genre>(CsvFiles.TitleBasics, dbContext, (s => new Genre() {GenreName = s}), "genres");
    //genresFiller.Fill();
    
    //Dictionaries.MovieTypes
    var primaryMovieTypesFiller = new UniversalDictionaryFiller<TitleBasic, MovieType>(CsvFiles.TitleBasics, dbContext, (s => new MovieType() { MovieTypeName = s }), "titleType");
    //primaryMovieTypesFiller.Fill();

    //Dictionaries.Professions
    var professionFiller = new DictionariesProfessionsFiller(CsvFiles.NameBasics, dbContext);
    //professionFiller.Fill();
    
    //Names.Persons
    var personsFiller = new NamesPersonsFiller(CsvFiles.NameBasics, dbContext);
    //personsFiller.Fill();

    //Names.PrimaryProfessions
    var primaryProfessionFiller = new PrimaryProfessionFiller(CsvFiles.NameBasics, dbContext);
    //primaryProfessionFiller.Fill();

    //Titles.Movies
    var a = dbContext.MovieTypes;
    Movie TitleToMovie(TitleBasic t) => new Movie()
    {
        ImdbMovieId = t.tconst,
        Title = t.primaryTitle.Length < 250 ? t.primaryTitle : t.primaryTitle.Substring(0,250),
        OriginalTitle = t.originalTitle.Length < 250 ? t.originalTitle :t.originalTitle.Substring(0,250),
        MovieTypeId = a.First(x => x.MovieTypeName == t.titleType).MovieTypeId,
        Year = int.TryParse(t.startYear, out int startYear) ? startYear : 0,
        RuntimeMins = int.TryParse(t.runtimeMinutes, out var runtime) ? runtime : 0,
        YearEnd = int.TryParse(t.endYear, out var endYear) ? endYear : 0
    };
    var moviesFiller = new UniversalFiller<TitleBasic, Movie>(CsvFiles.TitleBasics, dbContext, TitleToMovie);
    //moviesFiller.Fill();

    ////////////////////////////////TmpTables

    //TmpTitleAkas ------------ CANCEL

    //TmpTitleCrew ------------ CANCEL

    //TmpTitleEpisodes
    var tmpEpisodesFiller = new UniversalFiller<TitleEpisode, TmpEpisode>(CsvFiles.TitleEpisode, dbContext, (x) =>
        new TmpEpisode()
        {
            Tconst = x.tconst,
            ParentTconst = x.parentTconst,
            SeasonNumber = int.TryParse(x.seasonNumber, out var sNum) ? sNum : null,
            EpisodeNumber = int.TryParse(x.episodeNumber, out var epNum) ? epNum : null
        }
    );
    //tmpEpisodesFiller.Fill();

    //TmpNameBasicsKnownFor
    var tmpKnownFor = new TmpNameBasicsKnownForFiller(CsvFiles.NameBasics, dbContext);
    //tmpKnownFor.Fill();

    //Tmp.PrimaryProfessions
    var personPrimaryProfessionFiller = new TmpPersonPrimaryProfessionFiller(CsvFiles.NameBasics, dbContext);
    //personPrimaryProfessionFiller.Fill();
    
    //TmpTitlePrincipals
    var tmpTitlePrincipalsFiller = new UniversalFiller<TitlePrincipal,TmpPrincipal>(CsvFiles.TitlePrincipals,dbContext, x =>new TmpPrincipal()
    {
        Tconst = x.tconst,
        Ordering = int.TryParse(x.ordering, out var or) ? or : null,
        Nconst = x.nconst,
        Category = x.category,
        Job = x.job,
        Character = x.characters
    });
    //IS NOT RAN tmpTitlePrincipalsFiller.Fill();

    //TmpTitleBasicsGenres
    var tmpMovieGenresFiller = new TmpTitleBasicsGenres(CsvFiles.TitleBasics, dbContext);
    //IS NOT RAN tmpMovieGenresFiller.Fill();

    //TmpTitleRatings
    var tmpTitleRatingsFiller = new UniversalFiller<TitleRating, TmpTitleRating>(CsvFiles.TitleRatings, dbContext,x => new TmpTitleRating()
    {
        Tconst = x.tconst,
        AverageRating = decimal.TryParse(x.averageRating.Replace(".",","), out var rt) ? rt : null,
        NumVotes = int.TryParse(x.numVotes, out var nv) ? nv : null 
    });
    //tmpTitleRatingsFiller.Fill();

}


Console.WriteLine("Done!");
