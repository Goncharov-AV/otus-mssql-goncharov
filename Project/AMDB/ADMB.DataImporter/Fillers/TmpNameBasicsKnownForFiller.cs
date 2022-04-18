using ADMB.DataImporter.CsvModels;
using AMDB.Entities.DbContext;
using AMDB.Entities.Models;

namespace ADMB.DataImporter.Fillers;
public class TmpNameBasicsKnownForFiller
{
    private string NameBasicsPath { get; set; }
    private AmdbContext DbContext { get; set; }
    public TmpNameBasicsKnownForFiller(string nameBasicsPath, AmdbContext dbContext)
    {
        NameBasicsPath = nameBasicsPath;
        DbContext = dbContext;
    }
    public void Fill()
    {
        var persons = GetCsvInfo();

        AddKnownForToDb(persons);

        Console.WriteLine("Done");
    }

    private IEnumerable<NameBasic> GetCsvInfo()
    {
        var reader = new CsvTypeReader<NameBasic>(NameBasicsPath);

        var nameBasics = reader.ReadRecords();

        return nameBasics;
    }

    private void AddKnownForToDb(IEnumerable<NameBasic> nameBasics)
    {
        int count = 0;
        int count2 = 0;

        IEnumerable<TmpKnownFor> personKnownFor = new List<TmpKnownFor>();

        foreach (var record in nameBasics)
        {

            personKnownFor = record.knownForTitles.Split(",")
                .Select(x => new TmpKnownFor()
                {
                    PersonImdbId = record.nconst,
                    KnownFor = x
                });

            DbContext.AddRange(personKnownFor);

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

        DbContext.AddRange(personKnownFor);
        DbContext.SaveChanges();

        Console.WriteLine("Done");
    }
}