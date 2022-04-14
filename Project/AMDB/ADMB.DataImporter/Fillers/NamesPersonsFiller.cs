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
        var counter = 0;
        var step = 10000;
        var personsEntities = new List<Person>();

        foreach (var record in nameBasics)
        {
            if (counter == step)
            {
                Console.WriteLine(counter);


                using (AmdbContext dbContext = new AmdbContext())
                {
                    dbContext.Persons.AddRange(personsEntities);
                    dbContext.SaveChanges();
                }
                
                counter = 0;
                personsEntities.Clear();
            }

            var person = new Person()
            {
                PersonImdbId = record.nconst,
                Name = record.primaryName,
                BirthDate = record.birthYear != "\\N" ? new DateTime(int.Parse(record.birthYear), 1, 1) : null,
                DeathDate = record.deathYear != "\\N" ? new DateTime(int.Parse(record.deathYear), 1, 1) : null
            };

            personsEntities.Add(person);

            counter++;
        }

        using (AmdbContext dbContext = new AmdbContext())
        {
            dbContext.Persons.AddRange(personsEntities);
            dbContext.SaveChanges();
        }

        Console.WriteLine("Done");
    }
}