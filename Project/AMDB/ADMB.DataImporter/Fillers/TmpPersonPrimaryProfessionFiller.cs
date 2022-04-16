using ADMB.DataImporter.CsvModels;
using AMDB.Entities.DbContext;
using AMDB.Entities.Models;

namespace ADMB.DataImporter.Fillers;

public class TmpPersonPrimaryProfessionFiller
{
    private string NameBasicsPath { get; set; }
    private AmdbContext DbContext { get; set; }
    public TmpPersonPrimaryProfessionFiller(string nameBasicsPath, AmdbContext dbContext)
    {
        NameBasicsPath = nameBasicsPath;
        DbContext = dbContext;
    }
    public void Fill()
    {
        var persons = GetCsvInfo();

        AddPrimaryProfessoinsToDb(persons);

        Console.WriteLine("Done");
    }

    private IEnumerable<NameBasic> GetCsvInfo()
    {
        var reader = new CsvTypeReader<NameBasic>(NameBasicsPath);

        var nameBasics = reader.ReadRecords();

        return nameBasics;
    }

    private void AddPrimaryProfessoinsToDb(IEnumerable<NameBasic> nameBasics)
    {
        int count = 0;
        int count2 = 0;

        IEnumerable<PersonPrimaryProfession> personPrimaryProfessions = new List<PersonPrimaryProfession>();

        foreach (var record in nameBasics)
        {

            personPrimaryProfessions = record.primaryProfession.Split(",")
                .Select(x => new PersonPrimaryProfession()
                {
                    PersonImdbId = record.nconst,
                    Profession = x
                });

            DbContext.AddRange(personPrimaryProfessions);

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

        DbContext.AddRange(personPrimaryProfessions);
        DbContext.SaveChanges();

        Console.WriteLine("Done");
    }
}