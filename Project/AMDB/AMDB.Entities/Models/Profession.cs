using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class Profession
    {
        public Profession()
        {
            PrimaryProfessions = new HashSet<PrimaryProfession>();
            Teams = new HashSet<Team>();
        }

        public int ProfessionId { get; set; }
        public string Profession1 { get; set; } = null!;

        public virtual ICollection<PrimaryProfession> PrimaryProfessions { get; set; }
        public virtual ICollection<Team> Teams { get; set; }
    }
}
