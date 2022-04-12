using ADMB.DataImporter.CsvModels;
using AMDB.Entities.DbContext;
using AMDB.Entities.Models;

namespace ADMB.DataImporter.Fillers;

public class DictionariesProfessionsFiller
{
    private string NameBasicsPath { get; set; }
    private AmdbContext DbContext { get; set; }
    public DictionariesProfessionsFiller(string nameBasicsPath, AmdbContext dbContext)
    {
        NameBasicsPath = nameBasicsPath;
        DbContext = dbContext;
    }
    public void Fill()
    {
        var professions = GetCsvInfo();

        SaveProfessionsToDb(professions);

        Console.WriteLine("Done");
    }

    private SortedSet<string> GetCsvInfo()
    {
        var reader = new CsvTypeReader<NameBasic>(NameBasicsPath);

        SortedSet<string> professions = new SortedSet<string>();

        foreach (var record in reader.ReadRecords())
        {
            foreach (var profession in record.primaryProfession.Split(","))
            {
                professions.Add(profession);
            }
        }

        return professions;
    }

    private void SaveProfessionsToDb(SortedSet<string> professions)
    {
        foreach (var dbContextProfession in DbContext.Professions)
        {
            professions.RemoveWhere(x => x == dbContextProfession.Profession1);
        }

        if (professions.Any())
        {
            var professionsEntities = professions.Select(x => new Profession() { Profession1 = x }).ToList();

            DbContext.Professions.AddRange(professionsEntities);
            DbContext.SaveChanges();
        }
    }
}