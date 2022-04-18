using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class TmpAka
    {
        public int Id { get; set; }
        public string? TitleId { get; set; }
        public int? Ordering { get; set; }
        public string? Title { get; set; }
        public string? Region { get; set; }
        public string? Language { get; set; }
        public string? Types { get; set; }
        public string? Attributes { get; set; }
        public string? IsOriginalTitle { get; set; }
    }
}
