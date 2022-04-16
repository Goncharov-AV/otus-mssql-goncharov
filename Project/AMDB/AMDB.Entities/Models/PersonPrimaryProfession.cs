using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class PersonPrimaryProfession
    {
        public int Id { get; set; }
        public string? PersonImdbId { get; set; }
        public string? Profession { get; set; }
    }
}
