using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class Person
    {
        public Person()
        {
            Casts = new HashSet<Cast>();
            KnownFors = new HashSet<KnownFor>();
            PrimaryProfessions = new HashSet<PrimaryProfession>();
            Teams = new HashSet<Team>();
        }

        public int PersonId { get; set; }
        public string? PersonImdbId { get; set; }
        public string? Name { get; set; }
        public string? Summary { get; set; }
        public DateTime? BirthDate { get; set; }
        public DateTime? DeathDate { get; set; }

        public virtual ICollection<Cast> Casts { get; set; }
        public virtual ICollection<KnownFor> KnownFors { get; set; }
        public virtual ICollection<PrimaryProfession> PrimaryProfessions { get; set; }
        public virtual ICollection<Team> Teams { get; set; }
    }
}
