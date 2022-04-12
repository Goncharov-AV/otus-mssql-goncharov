using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CsvHelper;
using CsvHelper.Configuration;

namespace ADMB.DataImporter
{
    internal class CsvTypeReader<T>
    {
        public string Path { get; set; }
        public CsvTypeReader(string path)
        {
            Path = path;
        }

        public IEnumerable<T> ReadRecords()
        {
            var csvConfiguration = new CsvConfiguration(CultureInfo.InvariantCulture)
            {
                Delimiter = "\t",
            };
            csvConfiguration.Escape = '"';
            csvConfiguration.Mode = CsvMode.NoEscape;

            using var reader = new StreamReader(Path);
            using var csv = new CsvReader(reader, csvConfiguration);
            var records = csv.GetRecords<T>();
            foreach (var record in records)
            {
                yield return record;
            }
        }
    }
}
