using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace AMDB.Entities.Models
{
    public partial class AmdbContext : DbContext
    {
        public AmdbContext()
        {
        }

        public AmdbContext(DbContextOptions<AmdbContext> options)
            : base(options)
        {
        }

        public virtual DbSet<BoxOffice> BoxOffices { get; set; } = null!;
        public virtual DbSet<Cast> Casts { get; set; } = null!;
        public virtual DbSet<Company> Companies { get; set; } = null!;
        public virtual DbSet<ContentRating> ContentRatings { get; set; } = null!;
        public virtual DbSet<Country> Countries { get; set; } = null!;
        public virtual DbSet<EpisodesInfo> EpisodesInfos { get; set; } = null!;
        public virtual DbSet<Genre> Genres { get; set; } = null!;
        public virtual DbSet<Keyword> Keywords { get; set; } = null!;
        public virtual DbSet<KnownFor> KnownFors { get; set; } = null!;
        public virtual DbSet<Language> Languages { get; set; } = null!;
        public virtual DbSet<Movie> Movies { get; set; } = null!;
        public virtual DbSet<MovieCompany> MovieCompanies { get; set; } = null!;
        public virtual DbSet<MovieKeyword> MovieKeywords { get; set; } = null!;
        public virtual DbSet<Person> Persons { get; set; } = null!;
        public virtual DbSet<PrimaryProfession> PrimaryProfessions { get; set; } = null!;
        public virtual DbSet<Profession> Professions { get; set; } = null!;
        public virtual DbSet<Rating> Ratings { get; set; } = null!;
        public virtual DbSet<RatingName> RatingNames { get; set; } = null!;
        public virtual DbSet<Similar> Similars { get; set; } = null!;
        public virtual DbSet<Team> Teams { get; set; } = null!;
        public virtual DbSet<Type> Types { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Data Source=EMI-N-ET410002;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Connect Timeout=60;Encrypt=False;TrustServerCertificate=False", x => x.UseNetTopologySuite());
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<BoxOffice>(entity =>
            {
                entity.ToTable("BoxOffice", "Titles");

                entity.Property(e => e.BoxOfficeId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[BoxOfficeId])");

                entity.Property(e => e.Buget).HasMaxLength(255);

                entity.Property(e => e.CumulativeWorldwideGross).HasMaxLength(255);

                entity.Property(e => e.GrossUsa)
                    .HasMaxLength(255)
                    .HasColumnName("GrossUSA");

                entity.Property(e => e.OpeningWeekendUsa)
                    .HasMaxLength(255)
                    .HasColumnName("OpeningWeekendUSA");
            });

            modelBuilder.Entity<Cast>(entity =>
            {
                entity.ToTable("Cast", "Titles");

                entity.Property(e => e.CastId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[CastId])");

                entity.Property(e => e.Character).HasMaxLength(255);

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.Casts)
                    .HasForeignKey(d => d.MovieId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Titles_Cast_Titles_Movies");

                entity.HasOne(d => d.Person)
                    .WithMany(p => p.Casts)
                    .HasForeignKey(d => d.PersonId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Titles_Cast_Names_Persons");
            });

            modelBuilder.Entity<Company>(entity =>
            {
                entity.ToTable("Companies", "Companies");

                entity.Property(e => e.CompanyId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[CompanyId])");
            });

            modelBuilder.Entity<ContentRating>(entity =>
            {
                entity.ToTable("ContentRatings", "Dictionaries");

                entity.Property(e => e.ContentRatingId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[ContentRatingId])");

                entity.Property(e => e.ContentRating1)
                    .HasMaxLength(255)
                    .HasColumnName("ContentRating");
            });

            modelBuilder.Entity<Country>(entity =>
            {
                entity.ToTable("Countries", "Dictionaries");

                entity.Property(e => e.CountryId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[CountryId])");

                entity.Property(e => e.Country1)
                    .HasMaxLength(255)
                    .HasColumnName("Country");
            });

            modelBuilder.Entity<EpisodesInfo>(entity =>
            {
                entity.HasKey(e => e.EpisodeInfoId)
                    .HasName("PK__Episodes__30BB6AAD09C02E8D");

                entity.ToTable("EpisodesInfo", "Titles");

                entity.Property(e => e.EpisodeInfoId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[EpisodeInfoId])");

                entity.HasOne(d => d.Series)
                    .WithMany(p => p.EpisodesInfos)
                    .HasForeignKey(d => d.SeriesId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Titles_EpisodeInfo_Titles_Movies");
            });

            modelBuilder.Entity<Genre>(entity =>
            {
                entity.ToTable("Genres", "Dictionaries");

                entity.Property(e => e.GenreId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[GenreId])");

                entity.Property(e => e.GenreName).HasMaxLength(255);
            });

            modelBuilder.Entity<Keyword>(entity =>
            {
                entity.ToTable("Keywords", "Dictionaries");

                entity.Property(e => e.KeywordId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[KeywordId])");

                entity.Property(e => e.Keyword1)
                    .HasMaxLength(255)
                    .HasColumnName("Keyword");
            });

            modelBuilder.Entity<KnownFor>(entity =>
            {
                entity.ToTable("KnownFor", "Names");

                entity.Property(e => e.KnownForId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[KnownForId])");

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.KnownFors)
                    .HasForeignKey(d => d.MovieId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Names_KnownFor_Titles_Movies");

                entity.HasOne(d => d.Person)
                    .WithMany(p => p.KnownFors)
                    .HasForeignKey(d => d.PersonId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Names_KnownFor_Names_Persons");
            });

            modelBuilder.Entity<Language>(entity =>
            {
                entity.ToTable("Languages", "Dictionaries");

                entity.Property(e => e.Id).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[LanguageId])");

                entity.Property(e => e.Language1)
                    .HasMaxLength(255)
                    .HasColumnName("Language");
            });

            modelBuilder.Entity<Movie>(entity =>
            {
                entity.ToTable("Movies", "Titles");

                entity.Property(e => e.MovieId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[MovieId])");

                entity.Property(e => e.FullTitle).HasMaxLength(255);

                entity.Property(e => e.ImdbMovieId).HasMaxLength(255);

                entity.Property(e => e.OriginalTitle).HasMaxLength(255);

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.HasOne(d => d.BoxOffice)
                    .WithMany(p => p.Movies)
                    .HasForeignKey(d => d.BoxOfficeId)
                    .HasConstraintName("FK_Titles_Movies_Titles_BoxOffice");

                entity.HasOne(d => d.ContentRating)
                    .WithMany(p => p.Movies)
                    .HasForeignKey(d => d.ContentRatingId)
                    .HasConstraintName("FK_Titles_Movies_Dictionaties_ContentRatings");

                entity.HasOne(d => d.EpisodeInfo)
                    .WithMany(p => p.Movies)
                    .HasForeignKey(d => d.EpisodeInfoId)
                    .HasConstraintName("FK_Titles_Movies_Titles_EpisodesInfo");

                entity.HasOne(d => d.Type)
                    .WithMany(p => p.Movies)
                    .HasForeignKey(d => d.TypeId)
                    .HasConstraintName("FK_Titles_Movies_Dictionaries_Types");
            });

            modelBuilder.Entity<MovieCompany>(entity =>
            {
                entity.ToTable("MovieCompanies", "Titles");

                entity.Property(e => e.MovieCompanyId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[MovieCompanyId])");

                entity.HasOne(d => d.Company)
                    .WithMany(p => p.MovieCompanies)
                    .HasForeignKey(d => d.CompanyId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Titles_MovieCompanies_Companies_Companies");

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.MovieCompanies)
                    .HasForeignKey(d => d.MovieId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Titles_MovieCompanies_Titles_Movies");
            });

            modelBuilder.Entity<MovieKeyword>(entity =>
            {
                entity.HasKey(e => e.MovieKeywordsId)
                    .HasName("PK__MovieKey__8BD047871C8CA527");

                entity.ToTable("MovieKeywords", "Titles");

                entity.Property(e => e.MovieKeywordsId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[MovieKeywordId])");

                entity.HasOne(d => d.Keyword)
                    .WithMany(p => p.MovieKeywords)
                    .HasForeignKey(d => d.KeywordId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Titles_MovieKeywords_Dictionaries_Keywords");

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.MovieKeywords)
                    .HasForeignKey(d => d.MovieId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Titles_MovieKeywords_Titles_Movies");
            });

            modelBuilder.Entity<Person>(entity =>
            {
                entity.ToTable("Persons", "Names");

                entity.Property(e => e.PersonId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[PersonId])");

                entity.Property(e => e.Name).HasMaxLength(255);

                entity.Property(e => e.PersonImdbId).HasMaxLength(255);
            });

            modelBuilder.Entity<PrimaryProfession>(entity =>
            {
                entity.ToTable("PrimaryProfessions", "Names");

                entity.Property(e => e.PrimaryProfessionId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[PrimaryProfessionId])");

                entity.HasOne(d => d.Person)
                    .WithMany(p => p.PrimaryProfessions)
                    .HasForeignKey(d => d.PersonId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Names_PrimaryProfessions_Names_Persons");

                entity.HasOne(d => d.Profession)
                    .WithMany(p => p.PrimaryProfessions)
                    .HasForeignKey(d => d.ProfessionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Names_PrimaryProfessions_Dictionaries_Professions");
            });

            modelBuilder.Entity<Profession>(entity =>
            {
                entity.ToTable("Professions", "Dictionaries");

                entity.Property(e => e.ProfessionId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[ProfessionId])");

                entity.Property(e => e.Profession1)
                    .HasMaxLength(255)
                    .HasColumnName("Profession");
            });

            modelBuilder.Entity<Rating>(entity =>
            {
                entity.ToTable("Ratings", "Ratings");

                entity.Property(e => e.RatingId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[RatingId])");

                entity.Property(e => e.Rating1)
                    .HasColumnType("decimal(3, 1)")
                    .HasColumnName("Rating");

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.Ratings)
                    .HasForeignKey(d => d.MovieId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Ratings_Ratings_Titles_Movies");

                entity.HasOne(d => d.RatingName)
                    .WithMany(p => p.Ratings)
                    .HasForeignKey(d => d.RatingNameId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Ratings_Ratings_Ratings_RatingNames");
            });

            modelBuilder.Entity<RatingName>(entity =>
            {
                entity.ToTable("RatingNames", "Ratings");

                entity.Property(e => e.RatingNameId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[RatingNameId])");

                entity.Property(e => e.Name).HasMaxLength(255);
            });

            modelBuilder.Entity<Similar>(entity =>
            {
                entity.ToTable("Similars", "Titles");

                entity.Property(e => e.SimilarId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[SimilarId])");

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.SimilarMovies)
                    .HasForeignKey(d => d.MovieId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Titles_Similars_MovieId_Titles_Movies");

                entity.HasOne(d => d.SimilarMovie)
                    .WithMany(p => p.SimilarSimilarMovies)
                    .HasForeignKey(d => d.SimilarMovieId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Titles_Similars_SimilarMovieId_Titles_Movies");
            });

            modelBuilder.Entity<Team>(entity =>
            {
                entity.ToTable("Teams", "Titles");

                entity.Property(e => e.TeamId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[TeamId])");

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.Teams)
                    .HasForeignKey(d => d.MovieId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Titles_Teams_Titles_Movies");

                entity.HasOne(d => d.Person)
                    .WithMany(p => p.Teams)
                    .HasForeignKey(d => d.PersonId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Titles_Teams_Names_Persons");

                entity.HasOne(d => d.Profession)
                    .WithMany(p => p.Teams)
                    .HasForeignKey(d => d.ProfessionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Titles_Teams_Dictionaries_Professions");
            });

            modelBuilder.Entity<Type>(entity =>
            {
                entity.ToTable("Types", "Dictionaries");

                entity.Property(e => e.TypeId).HasDefaultValueSql("(NEXT VALUE FOR [Sequences].[TypeId])");

                entity.Property(e => e.Type1)
                    .HasMaxLength(255)
                    .HasColumnName("Type");
            });

            modelBuilder.HasSequence("BoxOfficeId", "Sequences");

            modelBuilder.HasSequence("CastId", "Sequences");

            modelBuilder.HasSequence("CompanyId", "Sequences");

            modelBuilder.HasSequence("ContentRatingId", "Sequences");

            modelBuilder.HasSequence("CountryId", "Sequences");

            modelBuilder.HasSequence("EpisodeInfoId", "Sequences");

            modelBuilder.HasSequence("GenreId", "Sequences");

            modelBuilder.HasSequence("KeywordId", "Sequences");

            modelBuilder.HasSequence("KnownForId", "Sequences");

            modelBuilder.HasSequence("LanguageId", "Sequences");

            modelBuilder.HasSequence("MovieCompanyId", "Sequences");

            modelBuilder.HasSequence("MovieId", "Sequences");

            modelBuilder.HasSequence("MovieKeywordId", "Sequences");

            modelBuilder.HasSequence("PersonId", "Sequences");

            modelBuilder.HasSequence("PrimaryProfessionId", "Sequences");

            modelBuilder.HasSequence("ProfessionId", "Sequences");

            modelBuilder.HasSequence("RatingId", "Sequences");

            modelBuilder.HasSequence("RatingNameId", "Sequences");

            modelBuilder.HasSequence("SimilarId", "Sequences");

            modelBuilder.HasSequence("TeamId", "Sequences");

            modelBuilder.HasSequence("TypeId", "Sequences");

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
