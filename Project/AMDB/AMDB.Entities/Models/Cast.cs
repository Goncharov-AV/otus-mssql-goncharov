using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class Cast
    {
        public int CastId { get; set; }
        public int MovieId { get; set; }
        public int PersonId { get; set; }
        public string? Character { get; set; }

        public virtual Movie Movie { get; set; } = null!;
        public virtual Person Person { get; set; } = null!;
    }
}
