using ADMB.DataImporter.CsvModels;
using AMDB.Entities.DbContext;
using AMDB.Entities.Models;

namespace ADMB.DataImporter.Fillers;

public class NamesPersonsFiller
{
    private string NameBasicsPath { get; set; }
    private AmdbContext DbContext { get; set; }
    public NamesPersonsFiller(string nameBasicsPath, AmdbContext dbContext)
    {
        NameBasicsPath = nameBasicsPath;
        DbContext = dbContext;
    }
    public void Fill()
    {
        var persons = GetCsvInfo();

        AddPersonsToDb(persons);

        Console.WriteLine("Done");
    }

    private IEnumerable<NameBasic> GetCsvInfo()
    {
        var reader = new CsvTypeReader<NameBasic>(NameBasicsPath);

        var nameBasics = reader.ReadRecords();
        
        return nameBasics;
    }

    private void AddPersonsToDb(IEnumerable<NameBasic> nameBasics)
    {
        var temp = nameBasics.
    
        var personsEntities = nameBasics.Select(x => new Person() {});

        DbContext.Persons.AddRange(personsEntities);
        //DbContext.SaveChanges();
        Console.WriteLine("Done");
    }
}