using System.Globalization;
using ADMB.DataImporter;
using CsvHelper;
using CsvHelper.Configuration;

// See https://aka.ms/new-console-template for more information
Console.WriteLine("Hello, World!");

//IEnumerable<UserRating> records;
//List<UserRating> records;

//var csvConfiguration = new CsvConfiguration(CultureInfo.InvariantCulture)
//{
//    Delimiter = "\t"
//};
//
//using (var reader = new StreamReader($"c:\\_Sources\\otus-mssql-goncharov\\Project\\Datasets\\IMDB\\title.ratings.tsv\\data.tsv"))
//using (var csv = new CsvReader(reader, csvConfiguration))
//{
//    //records = csv.GetRecords<UserRating>().ToList();
//    var recs = csv.GetRecords<UserRating>();
//    foreach (var record in recs)
//    {
//        if (record != null)
//            Console.Write(record.tconst);
//    }
//}

//var result = records.ToList();

var path = $"c:\\_Sources\\otus-mssql-goncharov\\Project\\Datasets\\IMDB\\title.ratings.tsv\\data.tsv";
var reader = new CsvTypeReader<UserRating>(path);
var records = reader.ReadRecords();

foreach (var record in records)
{
    Console.WriteLine(record.tconst);
}

Console.WriteLine("Done!");
