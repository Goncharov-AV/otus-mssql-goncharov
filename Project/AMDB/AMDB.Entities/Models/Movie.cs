using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class Movie
    {
        public Movie()
        {
            Casts = new HashSet<Cast>();
            EpisodesInfos = new HashSet<EpisodesInfo>();
            KnownFors = new HashSet<KnownFor>();
            MovieCompanies = new HashSet<MovieCompany>();
            MovieCountries = new HashSet<MovieCountry>();
            MovieGenres = new HashSet<MovieGenre>();
            MovieKeywords = new HashSet<MovieKeyword>();
            MovieLanguages = new HashSet<MovieLanguage>();
            Ratings = new HashSet<Rating>();
            SimilarMovies = new HashSet<Similar>();
            SimilarSimilarMovies = new HashSet<Similar>();
            Teams = new HashSet<Team>();
        }

        public int MovieId { get; set; }
        public string? ImdbMovieId { get; set; }
        public string? Title { get; set; }
        public string? OriginalTitle { get; set; }
        public string? FullTitle { get; set; }
        public int? MovieTypeId { get; set; }
        public int? Year { get; set; }
        public DateTime? ReleaseDate { get; set; }
        public int? RuntimeMins { get; set; }
        public string? Plot { get; set; }
        public int? ContentRatingId { get; set; }
        public int? SeriesInfoId { get; set; }
        public int? YearEnd { get; set; }
        public int? EpisodeInfoId { get; set; }
        public int? BoxOfficeId { get; set; }

        public virtual BoxOffice? BoxOffice { get; set; }
        public virtual ContentRating? ContentRating { get; set; }
        public virtual EpisodesInfo? EpisodeInfo { get; set; }
        public virtual MovieType? MovieType { get; set; }
        public virtual ICollection<Cast> Casts { get; set; }
        public virtual ICollection<EpisodesInfo> EpisodesInfos { get; set; }
        public virtual ICollection<KnownFor> KnownFors { get; set; }
        public virtual ICollection<MovieCompany> MovieCompanies { get; set; }
        public virtual ICollection<MovieCountry> MovieCountries { get; set; }
        public virtual ICollection<MovieGenre> MovieGenres { get; set; }
        public virtual ICollection<MovieKeyword> MovieKeywords { get; set; }
        public virtual ICollection<MovieLanguage> MovieLanguages { get; set; }
        public virtual ICollection<Rating> Ratings { get; set; }
        public virtual ICollection<Similar> SimilarMovies { get; set; }
        public virtual ICollection<Similar> SimilarSimilarMovies { get; set; }
        public virtual ICollection<Team> Teams { get; set; }
    }
}
