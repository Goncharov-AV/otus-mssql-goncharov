using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class Rating
    {
        public int RatingId { get; set; }
        public int RatingNameId { get; set; }
        public int MovieId { get; set; }
        public decimal Rating1 { get; set; }

        public virtual Movie Movie { get; set; } = null!;
        public virtual RatingName RatingName { get; set; } = null!;
    }
}
