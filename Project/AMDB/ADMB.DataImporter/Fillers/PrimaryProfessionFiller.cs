using ADMB.DataImporter.CsvModels;
using AMDB.Entities.DbContext;
using AMDB.Entities.Models;

namespace ADMB.DataImporter.Fillers;

public class PrimaryProfessionFiller
{
    private string NameBasicsPath { get; set; }
    private AmdbContext DbContext { get; set; }
    public PrimaryProfessionFiller(string nameBasicsPath, AmdbContext dbContext)
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

        foreach (var record in nameBasics)
        {

            var primaryProfessions = record.primaryProfession.Split(",")
                .Select(x => new PrimaryProfession()
                {
                    PersonId = DbContext.Persons.First(p => p.PersonImdbId == record.nconst).PersonId,
                    ProfessionId = DbContext.Professions.First(r => r.Profession1 == x).ProfessionId
                });

            var tmp = primaryProfessions.ToList();

            DbContext.AddRange(primaryProfessions);

            if (count == 100000)
            {
                Console.WriteLine("Done");
            }

            count++;

            //DbContext.SaveChanges();
        }

        Console.WriteLine("Done");
    }
}