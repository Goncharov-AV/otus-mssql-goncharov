using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class ContentRating
    {
        public ContentRating()
        {
            Movies = new HashSet<Movie>();
        }

        public int ContentRatingId { get; set; }
        public string? ContentRating1 { get; set; }
        public int? AgeFrom { get; set; }

        public virtual ICollection<Movie> Movies { get; set; }
    }
}
