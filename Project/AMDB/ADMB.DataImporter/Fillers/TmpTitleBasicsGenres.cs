using ADMB.DataImporter;
using ADMB.DataImporter.CsvModels;
using AMDB.Entities.DbContext;
using AMDB.Entities.Models;

public class TmpTitleBasicsGenres
{
    private string TitleBasicsPath { get; set; }
    private AmdbContext DbContext { get; set; }

    public TmpTitleBasicsGenres(string titleBasicsPath, AmdbContext dbContext)
    {
        TitleBasicsPath = titleBasicsPath;
        DbContext = dbContext;
    }

    public void Fill()
    {
        var titles = GetCsvInfo();

        AddMovieGenresToDb(titles);

        Console.WriteLine("Done");
    }

    private IEnumerable<TitleBasic> GetCsvInfo()
    {
        var reader = new CsvTypeReader<TitleBasic>(TitleBasicsPath);

        var nameBasics = reader.ReadRecords();

        return nameBasics;
    }

    private void AddMovieGenresToDb(IEnumerable<TitleBasic> titleBasics)
    {
        int count = 0;
        int count2 = 0;

        IEnumerable<TmpTitleBasicsGenre> movieGenres = new List<TmpTitleBasicsGenre>();

        foreach (var record in titleBasics)
        {

            movieGenres = record.genres.Split(",")
                .Select(x => new TmpTitleBasicsGenre()
                {
                    Tconst = record.tconst,
                    Genre = x
                });

            DbContext.AddRange(movieGenres);

            if (count == 10000)
            {
                DbContext.SaveChanges();
                DbContext.ChangeTracker.Clear();
                Console.WriteLine(count2);
                count = 0;
            }

            count++;
            count2++;
        }

        DbContext.AddRange(movieGenres);
        DbContext.SaveChanges();

        Console.WriteLine("Done");
    }
}