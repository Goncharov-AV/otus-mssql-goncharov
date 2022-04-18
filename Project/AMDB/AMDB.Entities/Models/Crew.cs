using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class Crew
    {
        public int Id { get; set; }
        public string? Tconst { get; set; }
        public string? Directors { get; set; }
        public string? Writers { get; set; }
    }
}
