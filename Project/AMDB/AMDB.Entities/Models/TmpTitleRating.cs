using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class TmpTitleRating
    {
        public int Id { get; set; }
        public string? Tconst { get; set; }
        public decimal? AverageRating { get; set; }
        public int? NumVotes { get; set; }
    }
}
