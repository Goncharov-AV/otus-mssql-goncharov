using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class BoxOffice
    {
        public BoxOffice()
        {
            Movies = new HashSet<Movie>();
        }

        public int BoxOfficeId { get; set; }
        public string? Buget { get; set; }
        public string? OpeningWeekendUsa { get; set; }
        public string? GrossUsa { get; set; }
        public string? CumulativeWorldwideGross { get; set; }

        public virtual ICollection<Movie> Movies { get; set; }
    }
}
