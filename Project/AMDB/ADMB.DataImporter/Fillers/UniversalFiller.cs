namespace ADMB.DataImporter.Fillers;
using ADMB.DataImporter.CsvModels;
using AMDB.Entities.DbContext;
using AMDB.Entities.Models;

public class UniversalFiller<TCsvClass, TEntity>
{
    private string FilePath { get; set; }
    private AmdbContext DbContext { get; set; }
    private Func<TCsvClass, TEntity> Mapper { get; set; }
    public UniversalFiller(string nameBasicsPath, AmdbContext dbContext, Func<TCsvClass, TEntity> mapper)
    {
        FilePath = nameBasicsPath;
        DbContext = dbContext;
        Mapper = mapper;
    }
    public void Fill()
    {
        var csvObjects = GetCsvInfo();

        AddToDb(csvObjects);

        Console.WriteLine("Done");
    }

    private IEnumerable<TCsvClass> GetCsvInfo()
    {
        var reader = new CsvTypeReader<TCsvClass>(FilePath);

        var csvObjects = reader.ReadRecords();

        return csvObjects;
    }

    private void AddToDb(IEnumerable<TCsvClass> csvObjects)
    {
        int count = 0;
        int count2 = 0;

        IEnumerable<TEntity> entities = new List<TEntity>();

        foreach (var record in csvObjects)
        {
            if (count2 == 10560001)
                count = 0;
            if (count2 > 10560000)
            {
                var entity = Mapper(record);

                if (entity != null) DbContext.Add(entity);

                if (count == 10000)
                {
                    DbContext.SaveChanges();
                    DbContext.ChangeTracker.Clear();
                    Console.WriteLine(count2);
                    count = 0;
                }
            }
            
            
            count++;
            count2++;
        }

        //DbContext.AddRange(entities);
        DbContext.SaveChanges();

        Console.WriteLine("Done");
    }
}