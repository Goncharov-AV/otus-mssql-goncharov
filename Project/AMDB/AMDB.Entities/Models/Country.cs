using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class Country
    {
        public Country()
        {
            MovieCountries = new HashSet<MovieCountry>();
        }

        public int CountryId { get; set; }
        public string Country1 { get; set; } = null!;

        public virtual ICollection<MovieCountry> MovieCountries { get; set; }
    }
}
