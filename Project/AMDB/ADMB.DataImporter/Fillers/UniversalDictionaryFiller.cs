using ADMB.DataImporter.CsvModels;
using AMDB.Entities.DbContext;
using AMDB.Entities.Models;

namespace ADMB.DataImporter.Fillers;

public class UniversalDictionaryFiller<TCsvClass, TEntity>
{
    private string FilePath { get; set; }
    private AmdbContext DbContext { get; set; }
    private Func<string, TEntity> Mapper { get; set; }
    private string PropertyName { get; set; }
    public UniversalDictionaryFiller(string nameBasicsPath, AmdbContext dbContext, Func<string, TEntity> mapper, string propertyName)
    {
        FilePath = nameBasicsPath;
        DbContext = dbContext;
        Mapper = mapper;
        PropertyName = propertyName;
    }
    public void Fill()
    {
        var dictionaryList = GetCsvInfo();

        AddToDb(dictionaryList);

        Console.WriteLine("Done");
    }

    private IEnumerable<string> GetCsvInfo()
    {
        var reader = new CsvTypeReader<TCsvClass>(FilePath);

        var dictionaryList = new SortedSet<string>();

        var prop = typeof(TCsvClass).GetProperty(PropertyName);

        foreach (var record in reader.ReadRecords())
        {
            foreach (var subRecord in ((string)prop.GetValue(record)).Split(","))
            {
                dictionaryList.Add(subRecord);
            }
        }

        return dictionaryList;
    }

    private void AddToDb(IEnumerable<string> dictionaryList)
    {
        foreach (var record in dictionaryList)
        {

            var entity = Mapper(record);

            if (entity != null) DbContext.Add(entity);

        }

        DbContext.SaveChanges();

        Console.WriteLine("Done");
    }
}