using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class MovieCountry
    {
        public int MovieCountryId { get; set; }
        public int MovieId { get; set; }
        public int CountryId { get; set; }

        public virtual Country Country { get; set; } = null!;
        public virtual Movie Movie { get; set; } = null!;
    }
}
