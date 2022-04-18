using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class TmpPersonPrimaryProfession
    {
        public int Id { get; set; }
        public string? PersonImdbId { get; set; }
        public string? Profession { get; set; }
    }
}
