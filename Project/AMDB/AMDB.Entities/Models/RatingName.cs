using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class RatingName
    {
        public RatingName()
        {
            Ratings = new HashSet<Rating>();
        }

        public int RatingNameId { get; set; }
        public string Name { get; set; } = null!;

        public virtual ICollection<Rating> Ratings { get; set; }
    }
}
