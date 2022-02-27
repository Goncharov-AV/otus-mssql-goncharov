using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class KnownFor
    {
        public int KnownForId { get; set; }
        public int PersonId { get; set; }
        public int MovieId { get; set; }

        public virtual Movie Movie { get; set; } = null!;
        public virtual Person Person { get; set; } = null!;
    }
}
