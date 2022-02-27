using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class PrimaryProfession
    {
        public int PrimaryProfessionId { get; set; }
        public int PersonId { get; set; }
        public int ProfessionId { get; set; }

        public virtual Person Person { get; set; } = null!;
        public virtual Profession Profession { get; set; } = null!;
    }
}
