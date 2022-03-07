using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class MovieType
    {
        public MovieType()
        {
            Movies = new HashSet<Movie>();
        }

        public int MovieTypeId { get; set; }
        public string MovieTypeName { get; set; } = null!;

        public virtual ICollection<Movie> Movies { get; set; }
    }
}
