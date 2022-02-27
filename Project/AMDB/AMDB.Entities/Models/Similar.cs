using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class Similar
    {
        public int SimilarId { get; set; }
        public int MovieId { get; set; }
        public int SimilarMovieId { get; set; }

        public virtual Movie Movie { get; set; } = null!;
        public virtual Movie SimilarMovie { get; set; } = null!;
    }
}
