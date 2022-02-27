using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class Team
    {
        public int TeamId { get; set; }
        public int MovieId { get; set; }
        public int PersonId { get; set; }
        public int ProfessionId { get; set; }

        public virtual Movie Movie { get; set; } = null!;
        public virtual Person Person { get; set; } = null!;
        public virtual Profession Profession { get; set; } = null!;
    }
}
